class CreateThemeMsts < ActiveRecord::Migration
  def change
    create_table :theme_msts do |t|
      t.integer :theme_code, index: true, primary_key: true
      t.string :theme_type, limit: 100
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
