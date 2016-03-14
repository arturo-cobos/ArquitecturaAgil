# Sidekiq.rb
#
# Description: This file is created to set a default configuration for Sidekiq+Redis
# Creator: Luis Felipe Mendivelso
# Creation Date: 10-03-2016
# Last Moditication: 10-03-2016
# Version: 0.0.1

# Sidekiq Global Configuration
#
require 'sidekiq'

# In-Memory datastore
redis_conn = proc {
  Redis.new
}
# Server configuration por 250
Sidekiq.configure_server do |config|
  config.redis = {url: 'redis://localhost:6379/12'}
  config.redis = ConnectionPool.new(size: 250, &redis_conn)

end
# Client Configuration
Sidekiq.configure_client do |config|
  config.redis = {url: 'redis://localhost:6379/12'}
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

# Notification Worker
if ENV['TYPE_INSTANCE'] == 'AlertWorker'
  NotifierWorker.perform_async('Notifier Worker in Execution')
end