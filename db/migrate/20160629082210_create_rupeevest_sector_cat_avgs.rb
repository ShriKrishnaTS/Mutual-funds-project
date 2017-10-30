class CreateRupeevestSectorCatAvgs < ActiveRecord::Migration
  def change
    create_table :rupeevest_sector_cat_avgs do |t|
      t.integer :classification_id
      t.integer :rv_sect_code
      t.decimal :holdpercentage
      t.decimal :cat_avg

      t.timestamps null: false
    end
  end
end
