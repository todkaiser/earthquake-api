class ChangeTsunamiFormat < ActiveRecord::Migration[5.1]
  def change
    change_column :earthquakes, :tsunami, :float
  end
end
