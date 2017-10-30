class CreateCurrentnavs < ActiveRecord::Migration
  def change
    create_table :currentnavs do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :navdate
      t.decimal :navrs
      t.decimal :repurprice
      t.decimal :saleprice
      t.datetime :cldate
      t.decimal :change
      t.decimal :netchange
      t.decimal :prevnav
      t.datetime :prenavdate
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
