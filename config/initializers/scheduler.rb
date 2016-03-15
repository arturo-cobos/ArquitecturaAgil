
require 'rufus-scheduler'
# Notification Worker
if ENV['TYPE_INSTANCE'] == 'AlertWorker'
  scheduler = Rufus::Scheduler.new
  scheduler.every '12s' do
    #NotifierWorker.perform_async('Notifier Worker in Execution')
    puts 'Inicia Logica'
    ses = Aws::SES::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    puts 'Sesion con SES creada'
    sqs = Aws::SQS::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    puts 'Sesion con SQS creada'

    resp = sqs.receive_message(
        {
            queue_url: ENV['AWS_SQS_URL'].to_s, # required
            max_number_of_messages: 10,
        }
    )
    puts 'Poll de 10 mensajes de la Cola'
    puts 'Inicia Lectura de mensajes'
    resp.messages.each do |msg|
      puts 'Se verifica data del mensaje'
      puts msg.body.to_s
      puts 'Se consulta la información de la mascota'
      pet = Pet.find(Integer(Integer(msg.body)))
      puts 'Se trae al propietario de la mascota'
      owner = pet.user
      puts 'Se estructura el correo electronico a enviar'
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
      puts 'Message envidado ->'+resp.message_id
      sqs.delete_message(queue_url: ENV['AWS_SQS_URL'].to_s, receipt_handle: msg[:receipt_handle])
    end
    puts 'Fin del Proceso'
  end
end