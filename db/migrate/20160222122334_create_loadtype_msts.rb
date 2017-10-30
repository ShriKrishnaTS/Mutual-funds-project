class CreateLoadtypeMsts < ActiveRecord::Migration
  def change
    create_table :loadtype_msts do |t|
      t.integer :ltypecode, index: true, primary_key: true
      t.string :load, limit: 50
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
