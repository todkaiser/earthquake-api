class ChangeMagnitudeFormat < ActiveRecord::Migration[5.1]
  def change
    change_column :earthquakes, :magnitude, :float
  end
end
