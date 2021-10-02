class SecondarySchool < ApplicationRecord
  validates_presence_of :name, :lonlat

  scope :within, ->(longitude, latitude, distance_in_meters = 1000) {
    where(format(%{
     ST_Distance(lonlat, 'POINT(%f %f)') < %d
    }, longitude, latitude, distance_in_meters)) # approx
  }

end
