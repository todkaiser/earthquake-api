# ## Schema Information
# Schema version: 20180128043702
#
# Table name: `earthquakes`
#
# ### Columns
#
# Name                           | Type               | Attributes
# ------------------------------ | ------------------ | ---------------------------
# **`id`**                       | `integer`          | `not null, primary key`
# **`address`**                  | `string`           |
# **`administrative_division`**  | `string`           |
# **`country_code`**             | `string`           |
# **`latitude`**                 | `float`            |
# **`longitude`**                | `float`            |
# **`magnitude`**                | `float`            |
# **`time`**                     | `datetime`         |
# **`title`**                    | `string`           |
# **`tsunami`**                  | `float`            |
# **`created_at`**               | `datetime`         | `not null`
# **`updated_at`**               | `datetime`         | `not null`
# **`usgs_id`**                  | `string`           |
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
                   if: ->(obj) { obj.country_code.nil? || obj.administrative_division.nil? }
end
