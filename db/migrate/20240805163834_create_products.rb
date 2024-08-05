class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :website
      t.string :url

      t.timestamps
    end
  end
end
