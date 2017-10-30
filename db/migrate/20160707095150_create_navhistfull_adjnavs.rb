class CreateNavhistfullAdjnavs < ActiveRecord::Migration
  def change
    create_table :navhistfull_adjnavs do |t|
      t.integer :schemecode
      t.datetime :navdate
      t.decimal :navrs
      t.decimal :adjnavrs
      t.decimal :repurprice
      t.decimal :saleprice
      t.string :upd_flag

      t.timestamps null: false
    end
  end
end
