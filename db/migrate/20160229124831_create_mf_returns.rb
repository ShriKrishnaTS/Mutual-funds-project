class CreateMfReturns < ActiveRecord::Migration
  def change
    create_table :mf_returns do |t|
      t.decimal :schemecode, index: true, primary_key: true
      t.datetime :c_date
      t.datetime :p_date
      t.decimal :c_nav
      t.decimal :p_nav
      t.decimal :dyaret_1
      t.datetime :weekdate_1
      t.decimal :weeknav_1
      t.decimal :weekret_1
      t.datetime :mthdate_1
      t.decimal :mthnav_1
      t.decimal :monthret_1
      t.datetime :mthdate_3
      t.decimal :mthnav_3
      t.decimal :monthret_3
      t.datetime :mntdate_6
      t.decimal :mnthnav_6
      t.decimal :monthret_6
      t.datetime :mnthdate_9
      t.decimal :mnthnav_9
      t.decimal :mnthret_9
      t.datetime :yrdate_1
      t.decimal :yrnav_1
      t.decimal :yrret_1
      t.datetime :yrdate_2
      t.decimal :yrnav_2
      t.decimal :yearret_2
      t.datetime :yrdate_3
      t.decimal :yrnav_3
      t.decimal :yearret_3
      t.datetime :yrdate_4
      t.decimal :yrnav_4
      t.decimal :yearret_4
      t.datetime :yrdate_5
      t.decimal :yrnav_5
      t.decimal :yearret_5
      t.datetime :incdate
      t.decimal :incnav
      t.decimal :incret
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
