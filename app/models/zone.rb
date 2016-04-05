class Zone
  include Mongoid::Document
  field :pet_id, type: Integer
  field :latitude, type: Float
  field :longitude, type: Float
  field :radius, type: Float
end
