class CreateMfAnsReturns < ActiveRecord::Migration
  def change
    create_table :mf_ans_returns do |t|
      t.decimal :schemecode, precision: 10, scale: 10, index: true, primary_key: true
      t.datetime :c_date
      t.datetime :p_date
      t.decimal :c_nav, precision: 10, scale: 10
      t.decimal :p_nav, precision: 10, scale: 10
      t.decimal :dayret_1, precision: 10, scale: 10
      t.datetime :weekdate_1
      t.decimal :weeknav_1, precision: 10, scale: 10
      t.decimal :weekret_1, precision: 10, scale: 10
      t.datetime :mthdate_1
      t.decimal :mthnav_1, precision: 10, scale: 10
      t.decimal :monthret_1, precision: 10, scale: 10
      t.datetime :mthdate_3
      t.decimal :mthnav_3, precision: 10, scale: 10
      t.decimal :monthret_3, precision: 10, scale: 10
      t.datetime :mntdate_6
      t.decimal :mnthnav_6, precision: 10, scale: 10
      t.decimal :monthret_6, precision: 10, scale: 10
      t.datetime :mnthdate_9
      t.decimal :mnthnav_9, precision: 10, scale: 10
      t.decimal :mnthret_9, precision: 10, scale: 10
      t.datetime :yrdate_1
      t.decimal :yrnav_1, precision: 10, scale: 10
      t.decimal :yrret_1, precision: 10, scale: 10
      t.datetime :yrdate_2
      t.decimal :yrnav_2, precision: 10, scale: 10
      t.decimal :yearret_2, precision: 10, scale: 10
      t.datetime :yrdate_3
      t.decimal :yrnav_3, precision: 10, scale: 10
      t.decimal :yearret_3, precision: 10, scale: 10
      t.datetime :yrdate_4
      t.decimal :yrnav_4, precision: 10, scale: 10
      t.decimal :yearret_4, precision: 10, scale: 10
      t.datetime :yrdate_5
      t.decimal :yrnav_5, precision: 10, scale: 10
      t.decimal :yearret_5, precision: 10, scale: 10
      t.datetime :incdate
      t.decimal :incnav, precision: 10, scale: 10
      t.decimal :incret, precision: 10, scale: 10
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
