class ChangeColumnTypeToUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :latitude, :float
  	change_column :users, :longitude, :float
  end
end
