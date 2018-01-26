# == Schema Information
#
# Table name: earthquakes
#
#  id          :integer          not null, primary key
#  magnitude   :float
#  longitude   :float
#  latitude    :float
#  region_type :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  time        :datetime
#  usgs_id     :string
#  address     :string
#  tsunami     :decimal(, )
#

class Earthquake < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.region_type = geo.state
    end
  end

  # after_validation :reverse_geocode
end
