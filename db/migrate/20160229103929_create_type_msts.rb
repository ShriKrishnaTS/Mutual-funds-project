class CreateTypeMsts < ActiveRecord::Migration
  def change
    create_table :type_msts do |t|
      t.integer :type_code, index: true, primary_key: true
      t.string :type, limit: 50
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
