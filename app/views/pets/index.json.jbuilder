json.array!(@pets) do |pet|
  json.extract! pet, :id, :pet_type_id, :pet_status_id, :owner_id, :name, :gender, :description
  json.url pet_url(pet, format: :json)
end
