class AddUsgsId < ActiveRecord::Migration[5.1]
  def change
    add_column :earthquakes, :usgs_id, :string
  end
end
