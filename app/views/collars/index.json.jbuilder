json.array!(@collars) do |collar|
  json.extract! collar, :id, :pet_id, :reference, :description
  json.url collar_url(collar, format: :json)
end
