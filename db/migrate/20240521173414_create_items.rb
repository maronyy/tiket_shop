class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, null: false, default: "TRUE"
      t.datetime :created_at, null: false, default: "now"
      t.datetime :updated_at, null: false, default: "now"
    end
  end
end
