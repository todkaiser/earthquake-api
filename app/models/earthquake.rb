# ## Schema Information
# Schema version: 20180128112432
#
# Table name: `earthquakes`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`address`**       | `string`           |
# **`country`**       | `string`           |
# **`country_code`**  | `string`           |
# **`latitude`**      | `float`            |
# **`longitude`**     | `float`            |
# **`magnitude`**     | `float`            |
# **`state`**         | `string`           |
# **`state_code`**    | `string`           |
# **`time`**          | `datetime`         |
# **`title`**         | `string`           |
# **`tsunami`**       | `float`            |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`usgs_id`**       | `string`           |
#

class Earthquake < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.country = geo.country
      obj.country_code = geo.country_code
      obj.state = geo.state
      obj.state_code = geo.state_code
      obj.address = geo.address
    end
  end

  after_validation :reverse_geocode, if: -> {
    country.nil?  || country_code.nil? || state.nil?  || state_code.nil?
  }
end
