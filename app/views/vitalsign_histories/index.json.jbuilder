json.array!(@vitalsign_histories) do |vitalsign_history|
  json.extract! vitalsign_history, :id, :pet_id, :record_date, :breathing_freq, :heart_freq, :systolic, :diastolic
  json.url vitalsign_history_url(vitalsign_history, format: :json)
end
