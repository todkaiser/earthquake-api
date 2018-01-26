# == Schema Information
#
# Table name: earthquakes
#
#  id          :integer          not null, primary key
#  magnitude   :decimal(5, )
#  longitude   :string
#  latitude    :string
#  region_type :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Earthquake, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
