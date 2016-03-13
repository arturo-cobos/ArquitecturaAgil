class LocationAnalysisWorker
  include Sidekiq::Worker

  def perform(pet_id,longitud,latitud)
    zones = SafeZone.where(pet_id: pet_id)
    notify = false
    zones.each do |zone|
      if (latitud > zone.coorY1 or latitud < zone.coorY2)
        notify = true
      end
      if (longitud > zone.coorX1 or longitud < zone.coorX2)
        notify = true
      end
    end
    if notify
      sqs = Aws::SQS::Client.new(
          region: ENV['AWS_ADMIN_REGION'],
          credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET'])
      )
      msg = sqs.send_message(
          queue_url: ENV['AWS_SQS_URL'].to_s,
          message_body: pet_id.to_s
      )
      puts msg.to_s
      puts 'Se notifica al propietario'
    end
  end
end