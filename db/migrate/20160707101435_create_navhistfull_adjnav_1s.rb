class CreateNavhistfullAdjnav1s < ActiveRecord::Migration
  def change
    create_table :navhistfull_adjnav_1s do |t|
      t.integer :schemecode
      t.string :navdate
      t.decimal :navrs
      t.decimal :adjnavrs
      t.decimal :repurprice
      t.decimal :saleprice
      t.string :upd_flag

      t.timestamps null: false
    end
  end
end
