class AddCountryCodeColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :earthquakes, :country_code, :string
  end
end
