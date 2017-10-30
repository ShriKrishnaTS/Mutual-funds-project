class CreateSchemeRupeevests < ActiveRecord::Migration
  def change
    create_table :scheme_rupeevests do |t|
      t.integer :schemecode
      t.datetime :expenceratio_date
      t.decimal :expenceratio
      t.decimal :turnover_ratio
      t.datetime :turnover_date
      t.datetime :exitload_date
      t.decimal :exitload
      t.string :exitload_remarks
      t.datetime :inception_date
      t.decimal :inception_return
      t.decimal :lockperiod
      t.decimal :minimum_investment
      t.integer :redemption_period
      t.string :fund_manager
      t.string :fund_house
      t.decimal :navrs
      t.string :navchange
      t.string :decimal
      t.datetime :navdate
      t.datetime :aumdate
      t.decimal :aumtotal
      t.integer :index_code
      t.string :index_name
      t.integer :rank_ytd
      t.integer :rank_1month
      t.integer :rank_3month
      t.integer :rank_1year
      t.integer :rank_3year
      t.integer :rank_5year
      t.decimal :ytd_returns
      t.decimal :returns_1month
      t.decimal :returns_3month
      t.decimal :returns_1year
      t.decimal :returns_3year
      t.decimal :returns_5year

      t.timestamps null: false
    end
  end
end
