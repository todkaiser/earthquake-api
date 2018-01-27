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

require 'rails_helper'

RSpec.describe Earthquake, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
