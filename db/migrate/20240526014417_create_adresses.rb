class CreateAdresses < ActiveRecord::Migration[6.1]
  def change
    create_table :adresses do |t|
      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
