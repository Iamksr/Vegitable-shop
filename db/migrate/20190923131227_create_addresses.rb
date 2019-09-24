class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :country
      t.string :post_code
      t.string :state
      t.string :district

      t.timestamps
    end
  end
end
