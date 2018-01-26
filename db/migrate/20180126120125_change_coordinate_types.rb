class ChangeCoordinateTypes < ActiveRecord::Migration[5.1]
  def change
    change_column :earthquakes, :latitude, :float
    change_column :earthquakes, :longitude, :float
  end
end
