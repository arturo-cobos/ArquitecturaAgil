class Pet < ActiveRecord::Base
  belongs_to :pet_type
  belongs_to :pet_status
  belongs_to :owner
end
