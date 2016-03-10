# aws.rb
#
# Description: This file is created to set a default configuration for Amazon Web Service SDK
# Creator: Luis Felipe Mendivelso
# Creation Date: 10-03-2016
# Last Moditication: 10-03-2016
# Version: 0.0.1

# AWS Configuration
#
# Credentials Setup
Aws.config.update(
    {
        region: ENV['AWS_ADMIN_REGION'],
        credentials: Aws::Credentials.new(ENV['AWS_ADMIN_ID'], ENV['AWS_ADMIN_SECRET']  )
    }
)