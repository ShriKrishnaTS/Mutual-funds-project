class CreateRupeevestSectorIndustries < ActiveRecord::Migration
  def change
    create_table :rupeevest_sector_industries do |t|
      t.integer :rv_sect_code
      t.integer :ind_code

      t.timestamps null: false
    end
  end
end
