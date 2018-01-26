class ChangeDecimalPrecisions < ActiveRecord::Migration[5.1]
  def change
    change_column :earthquakes, :magnitude, :decimal, precision: 5, scale: 2
    change_column :earthquakes, :latitude, :decimal
    change_column :earthquakes, :longitude, :decimal
  end
end
