class RemoveIndexes < ActiveRecord::Migration[5.1]
  def change
    remove_index :earthquakes, :administrative_division
    remove_index :earthquakes, :magnitude
  end
end
