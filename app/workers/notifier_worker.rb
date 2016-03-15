# Dependencies
require 'sidekiq'

# Class Definition
class NotifierWorker
  include Sidekiq::Worker

  # 'perform' is a method predefined by Sidekiq:Worker to execute the logic need it in the job.
  def perform(data)
    puts data
    logger.info(data.to_s)
    logger.info('Inicia Logica')
    ses = Aws::SES::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    logger.info('Sesion con SES creada')
    sqs = Aws::SQS::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    logger.info('Sesion con SQS creada')

    resp = sqs.receive_message(
        {
            queue_url: ENV['AWS_SQS_URL'].to_s, # required
            max_number_of_messages: 10,
        }
    )
    logger.info('Poll de 10 mensajes de la Cola')
    logger.info('Inicia Lectura de mensajes')
    resp.messages.each do |msg|
      logger.info('Se verifica data del mensaje')
      puts msg.body.to_s
      logger.info('Se consulta la información de la mascota')
      pet = Pet.find(Integer(Integer(msg.body)))
      logger.info('Se trae al propietario de la mascota')
      owner = pet.user
      logger.info('Se estructura el correo electronico a enviar')
      resp = ses.send_email(
          {
              source: "lf.mendivelso10@uniandes.edu.co", # required
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
      logger.info('Message envidado ->'+resp.message_id)
      ses.delete_message(queue_url: ENV['AWS_SQS_URL'].to_s,receipt_handle: resp.receipt_handle,)
    end
    logger.info('Fin del Proceso')
  end
end