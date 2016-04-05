class ProcessTime
  include Mongoid::Document
  field :t_zero, type: Float
  field :t_one, type: Float
  field :t_two, type: Float
  field :t_total, type: Float
end
