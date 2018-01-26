# ## Schema Information
# Schema version: 20180126092145
#
# Table name: `earthquakes`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`latitude`**     | `string`           |
# **`longitude`**    | `string`           |
# **`magnitude`**    | `decimal(5, )`     | `indexed`
# **`region_type`**  | `string`           | `indexed`
# **`title`**        | `string`           |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#

class Earthquake < ApplicationRecord
end
