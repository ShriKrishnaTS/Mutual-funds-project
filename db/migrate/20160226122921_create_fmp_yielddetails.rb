class CreateFmpYielddetails < ActiveRecord::Migration
  def change
    create_table :fmp_yielddetails do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :maturitydate
      t.decimal :tenure_number
      t.string :tenure_option, limit: 10
      t.decimal :net_inticative_yield1
      t.decimal :net_inticative_yield2
      t.decimal :post_taxyield_ind1
      t.decimal :post_taxyield_ind2
      t.decimal :post_taxyield_nonind1
      t.decimal :post_taxyield_nonind2
      t.string :exit_load, limit: 30
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
