class RecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  # GET /records
  # GET /records.json
  def get
    render json: Record.all
  end

  # POST /records
  # POST /records.json
  def post
    t0_start_time = Time.now
    
    #Receiver
    record = Record.new(
        collar_id: params[:collar_id],
        latitude: params[:latitud],
        longitude: params[:longitud],
        breathing_freq: params[:frec_respiratoria],
        heart_freq: params[:frec_cardiaca],
        systolic: params[:p_sistolica],
        diastolic: params[:p_diastolica]
    )

    #Journaler
    Thread.new do
      record.save
    end

    #Un-marshaller
    collar = Collar.find_by(id: record.collar_id)
    location = LocationHistory.new(
        pet_id: collar.pet_id,
        record_date: Time.now,
        latitude: record.latitude,
        longitude: record.longitude
    )
    #location.save

    t0_end_time = Time.now
    t0_result = (t0_end_time - t0_start_time) * 1000.0
    #Replicator
    LocationAnalysisWorker.perform_async(location.pet_id, location.longitude, location.latitude, t0_result)

    #Request
    render json: record
  end
end
