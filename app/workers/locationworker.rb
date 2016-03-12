class LocationWorker
  include Sidekiq::Worker
  def perform(longitude, latitude)
    loc = Locations.new(
            longitude: params[:longitude] + 'ALGO',
            latitude: params[:latitude] + 'ALGO',
            datetime: Time.now
        )
        loc.save
  end
end