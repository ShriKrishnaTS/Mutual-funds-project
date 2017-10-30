class CreateNavhistfulls < ActiveRecord::Migration
  def change
    create_table :navhistfulls do |t|
      t.decimal :schemecode, index: true, primary_key: true
      t.datetime :navdate, index: true, primary_key: true
      t.decimal :navrs
      t.decimal :repurprice
      t.decimal :saleprice
      t.decimal :adjustednav_c
      t.decimal :adjustednav_nonc
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
