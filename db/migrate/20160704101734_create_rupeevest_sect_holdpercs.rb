class CreateRupeevestSectHoldpercs < ActiveRecord::Migration
  def change
    create_table :rupeevest_sect_holdpercs do |t|
      t.integer :schemecode
      t.integer :rv_sect_code
      t.decimal :hold_perc

      t.timestamps null: false
    end
  end
end
