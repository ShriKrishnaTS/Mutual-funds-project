class CreateDivMsts < ActiveRecord::Migration
  def change
    create_table :div_msts do |t|
      t.decimal :div_code, index: true, primary_key: true
      t.string :div_type, limit: 30
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
