# == Schema Information
#
# Table name: earthquakes
#
#  id          :integer          not null, primary key
#  magnitude   :decimal(2, )
#  longitude   :string
#  latitude    :string
#  region_type :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  time        :datetime
#

class Earthquake < ApplicationRecord
end
