class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :size
      t.string :description
      t.decimal :price
      t.integer :sqft
      t.string :promotion

      t.timestamps
    end
  end
end
