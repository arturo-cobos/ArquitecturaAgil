json.array!(@pet_types) do |pet_type|
  json.extract! pet_type, :id, :name, :description
  json.url pet_type_url(pet_type, format: :json)
end
