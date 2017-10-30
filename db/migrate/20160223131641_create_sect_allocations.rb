class CreateSectAllocations < ActiveRecord::Migration
  def change
    create_table :sect_allocations do |t|
      t.integer :amc_code
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :invdate, index: true, primary_key: true
      t.datetime :invenddate
      t.integer :srno, index: true, primary_key: true
      t.integer :sect_code
      t.string :sect_name, limit: 150
      t.integer :asect_code
      t.decimal :perc_hold
      t.decimal :value
      t.decimal :aum
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
