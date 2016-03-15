
require 'rufus-scheduler'
# Notification Worker
if ENV['TYPE_INSTANCE'] == 'AlertWorker'
  scheduler = Rufus::Scheduler.new
  scheduler.every '12s' do
    logger.info('Notification Worker start')
    ses = Aws::SES::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    logger.info('SES Sesion ON')
    sqs = Aws::SQS::Client.new(region: ENV['AWS_ADMIN_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']))
    logger.info('SQS Sesion ON')
    logger.info('Poll Messages')
    resp = sqs.receive_message(
        {
            queue_url: ENV['AWS_SQS_URL'].to_s, # required
            max_number_of_messages: 10,
        }
    )
    logger.info('Messages polled')
    logger.info('Evaluate all message')
    resp.messages.each do |msg|
      logger.info('Find Pet in the Message')
      pet = Pet.find(Integer(Integer(msg.body)))
      logger.info('Get Owner Information')
      owner = pet.user
      logger.info('Prepare the Email')
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
      logger.info('Message was sended to '+owner.email)
      sqs.delete_message(queue_url: ENV['AWS_SQS_URL'].to_s, receipt_handle: msg[:receipt_handle])
      logger.info('Message Queue Item was deleted')
    end
    puts 'Notification Worker end'
  end
end