class CreateSchemeAvgNums < ActiveRecord::Migration
  def change
    create_table :scheme_avg_nums do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :monthend, index: true, primary_key: true
      t.integer :amc_code
      t.decimal :avg_aum
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
