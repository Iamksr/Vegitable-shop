class AddColumnToCarts < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :is_done, :boolean
  end
end
