json.array!(@criminals) do |criminal|
  json.extract! criminal, :id, :nombre, :apellido, :cedula
  json.url criminal_url(criminal, format: :json)
end
