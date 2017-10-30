class CreateAvgMaturities < ActiveRecord::Migration
  def change
    create_table :avg_maturities do |t|
      t.integer :amc_code
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :date, index: true, primary_key: true
      t.datetime :invenddate
      t.decimal :avg_mat_num
      t.string :avg_mat_days, limit: 10
      t.decimal :mod_dur_num
      t.string :mod_dur_days, limit: 10
      t.decimal :ytm
      t.decimal :turnover_ratio
      t.string :tr_mode, limit: 10
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
