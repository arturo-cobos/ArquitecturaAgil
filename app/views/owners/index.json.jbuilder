json.array!(@owners) do |owner|
  json.extract! owner, :id, :email, :name, :last_name, :document_id, :phone, :cellphone
  json.url owner_url(owner, format: :json)
end
