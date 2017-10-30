class CreateSectAllocationCatavgs < ActiveRecord::Migration
  def change
    create_table :sect_allocation_catavgs do |t|
      t.integer :classification_id
      t.integer :sect_code
      t.decimal :sect_cat_avg

      t.timestamps null: false
    end
  end
end
