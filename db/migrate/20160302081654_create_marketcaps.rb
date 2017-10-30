class CreateMarketcaps < ActiveRecord::Migration
  def change
    create_table :marketcaps do |t|
      t.integer :ps_code, index: true, primary_key: true
      t.decimal :mcap_company
      t.datetime :trade_date
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
