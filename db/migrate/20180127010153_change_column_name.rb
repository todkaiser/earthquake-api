class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :earthquakes, :region_type, :administrative_division
  end
end
