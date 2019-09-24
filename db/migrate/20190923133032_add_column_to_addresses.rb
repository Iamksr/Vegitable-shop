class AddColumnToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :address, :string
  end
end
