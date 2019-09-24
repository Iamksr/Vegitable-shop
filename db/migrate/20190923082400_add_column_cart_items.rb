class AddColumnCartItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :cart_items, :quantity, :integer
  	add_column :cart_items, :quantity, :integer, :default => 1

  end
end
