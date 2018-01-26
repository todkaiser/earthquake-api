class AddTimeField < ActiveRecord::Migration[5.1]
  def change
    add_column :earthquakes, :time, :datetime
  end
end
