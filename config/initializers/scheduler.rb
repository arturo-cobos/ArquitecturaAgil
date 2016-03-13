


# Dependencies
require 'rufus-scheduler'

# Define the Scheduler Object
scheduler = Rufus::Scheduler.new

#Create the Cron Jobs
scheduler.in '20s' do
  #NotifierWorker.perform_async('Notifier Worker in Execution')
  credentials = Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET'])
  region = ENV['AWS_ADMIN_REGION']
  #puts data.to_s

  ses = Aws::SES::Client.new(
      region: region,
      credentials: credentials
  )

  poller = Aws::SQS::QueuePoller.new(ENV['AWS_SQS_URL'].to_s)

  poller.poll do |msg|
    puts msg.body.to_s
    pet = Pet.find(Integer(Integer(msg.body)))
    owner = pet.user
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
    puts 'Email: ID -> '+resp.message_id
  end
end