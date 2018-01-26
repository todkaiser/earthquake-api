class CreateEarthquakes < ActiveRecord::Migration[5.1]
  def change
    create_table :earthquakes do |t|
      t.decimal :magnitude, precision: 5
      t.string :longitude
      t.string :latitude
      t.string :region_type
      t.string :title

      t.timestamps
    end

    add_index :earthquakes, :magnitude
    add_index :earthquakes, :region_type
  end
end
