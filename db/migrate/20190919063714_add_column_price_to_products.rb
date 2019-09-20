class AddColumnPriceToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :full_price, :float
    add_column :products, :description, :string
  end
end
