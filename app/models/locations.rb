class Locations
  include Mongoid::Document
  field :longitude, type: String
  field :latitude, type: String
  field :datetime, type: Time
end
