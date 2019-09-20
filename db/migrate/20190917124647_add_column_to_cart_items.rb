class AddColumnToCartItems < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :unit_price, :float
    add_column :cart_items, :quantity, :integer
    add_column :cart_items, :price, :float
    add_column :cart_items, :is_active, :boolean
  end
end
