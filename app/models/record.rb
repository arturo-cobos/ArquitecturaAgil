class Record
  include Mongoid::Document
  field :dog_collar, type: String
  field :frec_cardiaca, type: Integer
  field :p_sistolica_integer, type: String
  field :p_diastolica, type: Integer
  field :frec_respiratoria, type: Integer
  field :longitud, type: Float
  field :latitud, type: Float
end
