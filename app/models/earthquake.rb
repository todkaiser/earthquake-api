# == Schema Information
#
# Table name: earthquakes
#
#  id                      :integer          not null, primary key
#  magnitude               :float
#  longitude               :float
#  latitude                :float
#  administrative_division :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  time                    :datetime
#  usgs_id                 :string
#  address                 :string
#  tsunami                 :float
#  country_code            :string
#

class Earthquake < ApplicationRecord
  alias_attribute :admin_region, :administrative_division

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.country_code = geo.country_code
      obj.administrative_division = geo.state
    end
  end

  after_validation :reverse_geocode,
                   if: -> (obj) { obj.country_code.nil? || obj.administrative_division.nil? }
end
