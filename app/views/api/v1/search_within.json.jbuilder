
json.status @status
json.content do
  json.type 'FeatureCollection'
  json.features @secondary_schools.each do |secondary_school|
    json.type 'Feature'
    json.properties do
      json.name secondary_school.name
      json.address secondary_school.address || nil
      json.unit_id secondary_school.unit_id || nil
    end
    json.geometry do
      json.type secondary_school.lonlat.geometry_type.type_name
      json.coordinates secondary_school.lonlat.coordinates
    end
  end
end
