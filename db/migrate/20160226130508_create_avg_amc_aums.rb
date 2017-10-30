class CreateAvgAmcAums < ActiveRecord::Migration
  def change
    create_table :avg_amc_aums do |t|
      t.integer :amc_code, index: true, primary_key: true
      t.datetime :aumdate, index: true, primary_key: true
      t.decimal :totalaum
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
