class LocationAnalysisWorker
  include Sidekiq::Worker

  def perform(pet_id,longitud,latitud, t0_result)
    t1_start_time = Time.now
    
    logger.info('Inicia Analisis de Localizacion')
    #zones = SafeZone.where(pet_id: pet_id)
    zones = Zone.where(pet_id: pet_id)
    logger.info('Busca todas las zonas asociadas a la mascota')
    notify = false
    logger.info('Inicia Ciclo de Zonas')
    #Validación de punto dentro de zona segura
    is_safe = 0
    
    p 'validando zonas'
    #Recorrer todas las zonas y revisar si la mascota se encuentra en por lo menos una de ellas
    zones.each do |zone|
      
      #calcular si se encuentra dentro del radio del punto central de la zona segura que se esta revisando
      is_safe = is_safe + (((longitud - zone.longitude)**2 + (latitud - zone.latitude)**2) < (zone.radius**2) ? 1 : 0)
      
      #si encuentra que la mascota esta dentro de una zona segura sale del ciclo para evitar procesamiento innecesario
      break if is_safe > 0
    end
    
    #notificar si la variable is_safe esta en cero lo que indica que no se encontro la mascota dentro de ninguna zona segura
    notify = is_safe > 0 ? false : true
    p 'Se debe notificar: ' + notify.to_s
    
    #/Validación de punto dentro de zona segura
    logger.info('Zona Resultado. Se tiene que notificar? R='+notify.to_s)

    if notify
      logger.info('Inicia Notificación en SQS')
      begin
        logger.info('Se crea una conexión con el servidor de colas')
        sqs = Aws::SQS::Client.new
        logger.info('Se envia el mensaje')
        t1_end_time = Time.now
        t1_result = (t1_end_time - t1_start_time) * 1000.0
        
        logger.info('Almacenamiento de datos estadisticos : ')
        statistics = Statistic.new(t_zero: t0_result, t_one: t1_result, t_two: t1_result, t_total: t0_result + t0_result + t1_result)
        Thread.new  do
          statistics.save
        end
        
        
        msg = sqs.send_message(
            queue_url: ENV['AWS_SQS_URL'].to_s,
            message_body: pet_id.to_s + '@' + t0_result + ',' + t1_result
        )
        logger.info('Mensaje Enviado : '+msg.message_id.to_s)
      rescue Aws::SQS::Errors::ServiceError
        logger.info('Falla en SQS : '+msg.message_id.to_s)
      end
    end
  end
end