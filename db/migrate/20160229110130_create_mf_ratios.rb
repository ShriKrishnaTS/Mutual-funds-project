class CreateMfRatios < ActiveRecord::Migration
  def change
    create_table :mf_ratios do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :upddate
      t.datetime :datefrom
      t.datetime :dateto
      t.decimal :avg_x
      t.decimal :avg_y
      t.decimal :sd_x
      t.decimal :sd_y
      t.decimal :semisd_x
      t.decimal :semisd_y
      t.decimal :beta_x
      t.decimal :beta_y
      t.decimal :corelation_x
      t.decimal :corelation_y
      t.decimal :betacor_x
      t.decimal :betacor_y
      t.decimal :treynor_x
      t.decimal :treynor_y
      t.decimal :fama_x
      t.decimal :fama_y
      t.decimal :sharpe_x
      t.decimal :sharpe_y
      t.decimal :jalpha_x
      t.decimal :jalpha_y
      t.decimal :sortino_x
      t.decimal :sortino_y
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
