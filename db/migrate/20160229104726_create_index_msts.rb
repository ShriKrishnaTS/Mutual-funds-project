class CreateIndexMsts < ActiveRecord::Migration
  def change
    create_table :index_msts do |t|
      t.integer :indexcode, index: true, primary_key: true
      t.integer :fincode
      t.string :scripcode, limit: 6
      t.string :indexname, limit: 100
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
