json.array!(@records) do |record|
  json.extract! record, :id, :collar_id, :latitude, :longitude, :breathing_freq, :heart_freq, :systolic, :diastolic
  json.url record_url(record, format: :json)
end
