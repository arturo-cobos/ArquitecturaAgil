
require 'rufus-scheduler'
# Notification Worker
if ENV['TYPE_INSTANCE'] == 'AlertWorker'

  #queue_time = 'queue_time.csv'
  #File.open(queue_time, "a+") do |f|
    #f.write("inicio;fin;diferencia(ms);\n")
  #end

  scheduler = Rufus::Scheduler.new
  scheduler.every '12s' do
    t2_start_time = Time.now
    
    Rails.logger.info('Notification Worker start')
    ses = Aws::SES::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_SES2_ID'], ENV['AWS_SES2_SECRET']))
    Rails.logger.info('SES Sesion ON')
    sqs = Aws::SQS::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    Rails.logger.info('SQS Sesion ON')
    Rails.logger.info('Poll Messages')
    
    resp = sqs.receive_message(
        {
            queue_url: ENV['AWS_SQS_URL'].to_s, # required
            max_number_of_messages: 10,
        }
    )
    
    Rails.logger.info('Messages polled')
    Rails.logger.info('Evaluate all message')
    t2_end_time = Time.now
    t2_result = (t2_end_time - t2_start_time) * 1000.0
    resp.messages.each do |msg|
      t2_start_time_item = Time.now
      Rails.logger.info('Find Pet in the Message')
      
      sqs_item = msg.body.split('@')
      p sqs_item[0]
      
      #Extracción de tiempos del proceso
      tiempos = sqs_item[1].split(',')
      t0_result = tiempos[0].to_f
      t1_result = tiempos[1].to_f
      
      #pet = Pet.find(Integer(Integer(msg.body)))
      Rails.logger.info('Get Owner Information')
      #owner = pet.user
      Rails.logger.info('Prepare the Email')
      #resp = ses.send_email(
      #    {
      #        source: "lf.mendivelso10@uniandes.edu.co", # required
      #        destination: {# required
      #                      to_addresses: [owner.email],
      #                      cc_addresses: [],
      #                      bcc_addresses: [],
      #        },
      #        message: {# required
      #                  subject: {# required
      #                            data: "Alert! - Your Pet exited from Safe Zone", # required
      #                            charset: "utf-8",
      #                  },
      #                  body: {# required
      #                         text: {
      #                             data: "Alert! - Your Pet exited from Safe Zone", # required
      #                             charset: "utf-8",
      #                         },
      #                         html: {
      #                             data: "Alert! - Your Pet exited from Safe Zone", # required
      #                             charset: "utf-8",
      #                         },
      #                  },
      #        }
      #    }
      #)
      #Rails.logger.info('Message was sended to '+owner.email)
      sqs.delete_message(queue_url: ENV['AWS_SQS_URL'].to_s, receipt_handle: msg[:receipt_handle])
      #Rails.logger.info('Message Queue Item was deleted')
      
      t2_end_time_item = Time.now
      t2_result_item = (t2_end_time_item - t2_start_time_item) * 1000.0
      t2_result = t2_result + t2_result_item
      
      #Extracción de tiempos
      
      
      Rails.logger.info("Tiempos: " + t0_result.to_s +  " - " + t1_result.to_s + " - " + t2_result.to_s)
      
      #Almacenamiento de tiempos para calculos estadisticos de latencia
      statistics = Statistic.new(t_zero: t0_result, t_one: t1_result, t_two: t2_result, t_total: t0_result + t1_result + t2_result)
      Thread.new do
        statistics.save
      end
    end
    
    puts 'Notification Worker end'
  end
end