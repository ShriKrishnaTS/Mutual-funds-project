class CreateBmIndicesRes < ActiveRecord::Migration
  def change
    create_table :bm_indices_res do |t|
      t.integer :index_code, index: true, primary_key: true
      t.datetime :date
      t.decimal :dayret_1
      t.datetime :weekdate_1
      t.decimal :weekclose_1
      t.decimal :weekret_1
      t.datetime :mthdate_1
      t.decimal :mthclose_1
      t.decimal :monthret_1
      t.datetime :mthdate_3
      t.decimal :mthclose_3
      t.decimal :monthret_3
      t.datetime :mthdate_6
      t.decimal :mthclose_6
      t.decimal :monthret_6
      t.datetime :mthdate_9
      t.decimal :mthclose_9
      t.decimal :monthret_9
      t.datetime :yrdate_1
      t.decimal :yrclose_1
      t.decimal :yrret_1
      t.datetime :yrdate_2
      t.decimal :yrclose_2
      t.decimal :yrret_2
      t.datetime :yrdate_3
      t.decimal :yrclose_3
      t.decimal :yrret_3
      t.datetime :yrdate_4
      t.decimal :yrclose_4
      t.decimal :yrret_4
      t.datetime :yrdate_5
      t.decimal :yrclose_5
      t.decimal :yrret_5
      t.datetime :incdate
      t.decimal :incclose
      t.decimal :incret
      t.datetime :weekdate_2
      t.float :weeknav_2
      t.float :weekret_2
      t.datetime :weekdate_3
      t.decimal :weeknav_3
      t.decimal :weekret_3
      t.datetime :mthdate_2
      t.decimal :mthnav_2
      t.datetime :monthret_2
      t.decimal :ytddate
      t.decimal :ytdnav
      t.decimal :ytdret
      t.string :upd_flag

      t.timestamps null: false
    end
  end
end
