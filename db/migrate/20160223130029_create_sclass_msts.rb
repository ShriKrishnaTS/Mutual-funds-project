class CreateSclassMsts < ActiveRecord::Migration
  def change
    create_table :sclass_msts do |t|
      t.integer :classcode, index: true, primary_key: true
      t.string :classname, limit: 100
      t.integer :asset_code
      t.string :asset_type, limit: 100
      t.string :category, limit: 100
      t.string :sub_category, limit: 100
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
