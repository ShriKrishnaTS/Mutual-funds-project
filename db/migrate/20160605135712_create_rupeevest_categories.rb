class CreateRupeevestCategories < ActiveRecord::Migration
  def change
    create_table :rupeevest_categories do |t|
      t.integer :classification_id
      t.integer :funds_num_ytd
      t.integer :funds_num_month1
      t.integer :funds_num_month3
      t.integer :funds_num_year1
      t.integer :funds_num_year3
      t.integer :funds_num_year5
      t.decimal :ytd_avg
      t.decimal :avg_month1
      t.decimal :avg_month3
      t.decimal :avg_year1
      t.decimal :avg_year3
      t.decimal :avg_year5
      t.decimal :avg_std_dev
      t.decimal :avg_sharpe
      t.decimal :avg_sotino
      t.decimal :avg_beta
      t.decimal :avg_alpha
      t.decimal :avg_treyno
      t.integer :no_of_funds_total
      t.decimal :avg_stocks_top10
      t.decimal :avg_stocks_top5
      t.decimal :avg_stocks_top3
      t.decimal :avg_num_of_sector
      t.decimal :avg_mod_duration
      t.decimal :avg_mat_avg
      t.decimal :avg_ytm
      t.decimal :avg_10year_return
      t.decimal :avg_9year_return
      t.decimal :avg_8year_return
      t.decimal :avg_7year_return
      t.decimal :avg_6year_return
      t.decimal :avg_5year_return
      t.decimal :avg_4year_return
      t.decimal :avg_3year_return
      t.decimal :avg_2year_return
      t.decimal :avg_1year_return
      t.decimal :avg_martketcap_avg
      t.decimal :large_perc_avg
      t.decimal :mid_perc_ave
      t.decimal :small_perc_avg

      t.timestamps null: false
    end
  end
end
