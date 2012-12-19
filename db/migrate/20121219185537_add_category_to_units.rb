class AddCategoryToUnits < ActiveRecord::Migration
  def up
    change_table :units do |t|
      t.string :category
    end
  end
 
  def down
    remove_column :units, :category
  end
end
