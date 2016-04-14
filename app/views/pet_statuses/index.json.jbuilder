json.array!(@pet_statuses) do |pet_status|
  json.extract! pet_status, :id, :name, :description
  json.url pet_status_url(pet_status, format: :json)
end
