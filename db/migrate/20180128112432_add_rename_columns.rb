class AddRenameColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :earthquakes, :country, :string
    add_column :earthquakes, :state_code, :string
    rename_column :earthquakes, :administrative_division, :state
  end
end
