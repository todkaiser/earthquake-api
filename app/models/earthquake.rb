# == Schema Information
#
# Table name: earthquakes
#
#  id          :integer          not null, primary key
#  magnitude   :decimal(5, 2)
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
end
