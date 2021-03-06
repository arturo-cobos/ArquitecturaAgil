#
# Class: RecordController
# Description: This controller manage all operations related with Records information arrived by Pet's Collar.
# @autor: Luis Felipe Mendivelso Osorio
# @since: 103-03-2016
# @version: 13-03-2016
# Last Modification: 13-03-2015
# Comentarios para validar la colaboración
class RecordController < ApplicationController

  # Get -> Return all record registered on the database
  def get
    render json: Record.all
  end

  # Post method add a new Record in the system and user a LMAX architecture to computing.
  def post
    t0_start_time = Time.now
    
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

    t0_end_time = Time.now
    t0_result = (t0_end_time - t0_start_time) * 1000.0
    #Replicator
    LocationAnalysisWorker.perform_async(location.pet_id, location.longitude, location.latitude, t0_result)

    #Request
    render json: record
  end

  def queue
    id = params[:id]
    sqs = Aws::SQS::Client.new
    sqs.send_message(
        queue_url: ENV['AWS_SQS_URL'].to_s,
        message_body: id.to_s
    )
    render json: id
  end
  
  def loader
	  render :text => "loaderio-9b75a2d089aa19f44f518eea85f61bcd"
  end
end
