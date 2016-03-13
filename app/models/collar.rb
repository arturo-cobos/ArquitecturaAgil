class Collar
  include Mongoid::Document
  field :collar_id, type: String
  field :pet_id, type: Integer
end
