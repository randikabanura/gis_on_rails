school_json = File.open('points.geojson').read
puts 'School json file read completed'

school_geo_json = RGeo::GeoJSON.decode(school_json)
puts 'School geo json read completed'

SecondarySchool.destroy_all
puts 'Old school date delete completed'

school_geo_json.each do |school|
  address = ''
  address += "#{school.property(:STREET)}, " if school.property(:STREET).present?
  address += "#{school.property(:CITY)}, " if school.property(:CITY).present?
  address += school.property(:STATE).to_s if school.property(:STATE).present?

  school_name = school.property(:NAME) if school.property(:NAME).present?
  unit_id = school.property(:UNITID) if school.property(:UNITID).present?

  if school_name
    SecondarySchool.create!(address: address, lonlat: school.geometry, name: school_name, unit_id: unit_id)
    puts "School added with name: #{school_name}"
  end
end

puts 'School data seeding completed'
