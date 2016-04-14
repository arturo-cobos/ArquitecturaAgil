json.array!(@safe_zones) do |safe_zone|
  json.extract! safe_zone, :id, :pet_id, :latitude, :longitude, :radium
  json.url safe_zone_url(safe_zone, format: :json)
end
