
require 'rufus-scheduler'
# Notification Worker
if ENV['TYPE_INSTANCE'] == 'AlertWorker'

  queue_time = '/var/www/html/queue_time.csv', 'w'
  File.open(queue_time, "a+") do |f|
    f.write("inicio;fin;diferencia(ms);\n")
  end

  scheduler = Rufus::Scheduler.new
  scheduler.every '12s' do
    start = Time.now
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
    resp.messages.each do |msg|
      Rails.logger.info('Find Pet in the Message')
      pet = Pet.find(Integer(Integer(msg.body)))
      Rails.logger.info('Get Owner Information')
      owner = pet.user
      Rails.logger.info('Prepare the Email')
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
      Rails.logger.info('Message was sended to '+owner.email)
      sqs.delete_message(queue_url: ENV['AWS_SQS_URL'].to_s, receipt_handle: msg[:receipt_handle])
      Rails.logger.info('Message Queue Item was deleted')
      finish = Time.now
      result = (finish - start) * 1000.0
      File.open(queue_time, "a+") do |f|
        f.write(start.to_datetime.to_s+';'+finish.to_datetime.to_s+';'+result.to_s+"\n")
      end
      puts 'Notification Worker end'
    end
    finish = Time.now
    result = (finish - start) * 1000.0
    File.open(queue_time, "a+") do |f|
      f.write(start.to_datetime.to_s+';'+finish.to_datetime.to_s+';'+result.to_s+"\n")
    end
    puts 'Notification Worker end'
  end
end