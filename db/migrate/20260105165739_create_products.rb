class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :condition, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
