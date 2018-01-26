# == Schema Information
#
# Table name: earthquakes
#
#  id          :integer          not null, primary key
#  magnitude   :decimal(5, 2)
#  longitude   :decimal(, )
#  latitude    :decimal(, )
#  region_type :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  time        :datetime
#  usgs_id     :string
#

class Earthquake < ApplicationRecord
end
