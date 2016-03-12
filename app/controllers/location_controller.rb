class LocationController < ApplicationController
    
    def index
        render json: "Index!!!"
    end
    
    def get
        render json: Locations.all
    end
    
    def post
        # Receiver
        loc = Locations.new(
              longitude: params[:longitude],
              latitude: params[:latitude],
              datetime: Time.now
          )
          
        # Journaler
        Thread.new do
          loc.save
        end
        
        # Replicate
        LocationWorker.new.perform(params[:longitude], params[:latitude])
        render json: loc
    end
    
end

class LocationWorker
  include Sidekiq::Worker
  def perform(longitude, latitude)
    # Se supone que esta es la cola de Sidekiq
  end
end