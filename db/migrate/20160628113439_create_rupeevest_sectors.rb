class CreateRupeevestSectors < ActiveRecord::Migration
  def change
    create_table :rupeevest_sectors do |t|
      t.integer :rv_sect_code
      t.string :rv_sect_name

      t.timestamps null: false
    end
  end
end
