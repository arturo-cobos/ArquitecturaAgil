class LocationAnalysisWorker
  include Sidekiq::Worker

  def perform(pet_id,longitud,latitud)
    logger.info('Inicia Analisis de Localizacion')
    zones = SafeZone.where(pet_id: pet_id)
    logger.info('Busca todas las zonas asociadas a la mascota')
    notify = true
    logger.info('Inicia Ciclo de Zonas')
    # zones.each do |zone|
    #   if (latitud > zone.coorY1 or latitud < zone.coorY2)
    #     notify = true
    #   end
    #   if (longitud > zone.coorX1 or longitud < zone.coorX2)
    #     notify = true
    #   end
    # end
    logger.info('Zona Resultado. Se tiene que notificar? R='+notify.to_s)

    if notify
      logger.info('Inicia Notificación en SQS')
      begin
        logger.info('Se crea una conexión con el servidor de colas')
        sqs = Aws::SQS::Client.new
        logger.info('Se envia el mensaje')
        msg = sqs.send_message(
            queue_url: ENV['AWS_SQS_URL'].to_s,
            message_body: pet_id.to_s
        )
        logger.info('Mensaje Enviado : '+msg.message_id.to_s)
      rescue Aws::SQS::Errors::ServiceError
        logger.info('Falla en SQS : '+msg.message_id.to_s)
      end
    end
  end
end