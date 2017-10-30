class CreateSectMsts < ActiveRecord::Migration
  def change
    create_table :sect_msts do |t|
      t.decimal :sect_code, index: true, primary_key: true
      t.string :sect_name
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
