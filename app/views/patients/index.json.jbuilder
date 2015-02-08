json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :first_name, :archived
  json.url patient_url(patient, format: :json)
end
