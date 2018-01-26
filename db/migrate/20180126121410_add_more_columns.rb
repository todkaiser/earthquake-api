class AddMoreColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :earthquakes, :address, :string
    add_column :earthquakes, :tsunami, :decimal
  end
end
