json.array!(@location_histories) do |location_history|
  json.extract! location_history, :id, :pet_id, :record_date, :latitude, :longitude
  json.url location_history_url(location_history, format: :json)
end
