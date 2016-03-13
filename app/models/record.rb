class Record
  include Mongoid::Document
  field :collar_id, type: String
  field :frec_cardiaca, type: Integer
  field :p_sistolica, type: Integer
  field :p_diastolica, type: Integer
  field :frec_respiratoria, type: Integer
  field :longitud, type: Float
  field :latitud, type: Float
end
