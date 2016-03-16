#
# Class: RecordController
# Description: This controller manage all operations related with Records information arrived by Pet's Collar.
# @autor: Luis Felipe Mendivelso Osorio
# @since: 103-03-2016
# @version: 13-03-2016
# Last Modification: 13-03-2015
#
class RecordController < ApplicationController

  # Get -> Return all record registered on the database
  def get
    render json: Record.all
  end

  # Post method add a new Record in the system and user a LMAX architecture to computing.
  def post
    #Receiver
    record = Record.new(
        collar_id: params[:collar_id],
        frec_cardiaca: params[:frec_cardiaca],
        p_sistolica: params[:p_sistolica],
        p_diastolica: params[:p_diastolica],
        frec_respiratoria: params[:frec_respiratoria],
        longitud: params[:longitud],
        latitud: params[:latitud]
    )

    #Journaler
    Thread.new do
      record.save
    end

    #Un-marshaller
    collar = Collar.find_by(collar_id: record.collar_id)
    location = Location.new(
        date: Time.now,
        latitude: record.latitud,
        longitude: record.longitud,
        pet_id: collar.pet_id
    )
    #location.save

    #Replicator
    LocationAnalysisWorker.perform_async(location.pet_id, location.longitude, location.latitude)

    #Request
    render json: record
  end

  def queue
    id = params[:id]
    queue_time = '/var/www/html/queue_time.csv'
    start = Time.now
    sqs = Aws::SQS::Client.new
    sqs.send_message(
        queue_url: ENV['AWS_SQS_URL'].to_s,
        message_body: id.to_s
    )

    ses = Aws::SES::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_SES2_ID'], ENV['AWS_SES2_SECRET']))
    resp = sqs.receive_message(
        {
            queue_url: ENV['AWS_SQS_URL'].to_s, # required
            max_number_of_messages: 10,
        }
    )
    resp.messages.each do |msg|
      pet = Pet.find(Integer(Integer(msg.body)))
      owner = pet.user
      resp = ses.send_email(
          {
              source: "abcmascotas.tester@gmail.com", # required
              destination: {# required
                            to_addresses: [owner.email],
                            cc_addresses: [],
                            bcc_addresses: [],
              },
              message: {# required
                        subject: {# required
                                  data: "Alert! - Your Pet exited from Safe Zone", # required
                                  charset: "utf-8",
                        },
                        body: {# required
                               text: {
                                   data: "Alert! - Your Pet exited from Safe Zone", # required
                                   charset: "utf-8",
                               },
                               html: {
                                   data: "Alert! - Your Pet exited from Safe Zone", # required
                                   charset: "utf-8",
                               },
                        },
              }
          }
      )
      sqs.delete_message(queue_url: ENV['AWS_SQS_URL'].to_s, receipt_handle: msg[:receipt_handle])
    end
    finish = Time.now
    result = (finish - start) * 1000.0
    File.open(queue_time, "a+") do |f|
      f.write(start.to_datetime.to_s+';'+finish.to_datetime.to_s+';'+result.to_s+"\n")
    end
    render json: id
  end
end
