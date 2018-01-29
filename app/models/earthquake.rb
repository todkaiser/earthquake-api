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
    geo = results.first

    if geo.present?
      obj.country = geo.country
      obj.country_code = geo.country_code
      obj.state = geo.state
      obj.state_code = geo.state_code
      obj.address = geo.address
    end
  end

  # # TODO This is temporarily disabled to prevent spamming the
  # # Google provided API. This service requires an API key for
  # # production-level performance. The free version usage limits
  # # are a max total 2500 requests / day and 50 requests / second.
  # after_validation :reverse_geocode, if: lambda {
  #   country.nil? || country_code.nil? || state.nil? || state_code.nil?
  # }
end
