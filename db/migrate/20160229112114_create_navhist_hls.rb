class CreateNavhistHls < ActiveRecord::Migration
  def change
      create_table :navhist_hls do |t|
        t.integer :schemecode, index: true, primary_key: true
        t.decimal :monthhhigh_3
        t.decimal :monthlow_3
        t.datetime :mhdate_3
        t.datetime :mldate_3
        t.decimal :monthhhigh_6
        t.decimal :monthlow_6
        t.datetime :mhdate_6
        t.datetime :mldate_6
        t.decimal :monthhhigh_9
        t.decimal :monthlow_9
        t.datetime :mhdate_9
        t.datetime :mldate_9
        t.decimal :weekhhigh_52
        t.decimal :weeklow_52
        t.datetime :whdate_52
        t.datetime :wldate_52
        t.decimal :yrhigh_1
        t.decimal :yrlow_1
        t.datetime :yhdate_1
        t.datetime :yldate_1
        t.decimal :yrhigh_2
        t.decimal :yrlow_2
        t.datetime :yhdate_2
        t.datetime :yldate_2
        t.decimal :yrhigh_3
        t.decimal :yrlow_3
        t.datetime :yhdate_3
        t.datetime :yldate_3
        t.decimal :yrhigh_5
        t.decimal :yrlow_5
        t.datetime :yhdate_5
        t.datetime :yldate_5
        t.decimal :ytdhigh
        t.decimal :ytdlow
        t.datetime :ytdhdate
        t.datetime :ytdldate
        t.decimal :sihigh
        t.decimal :silow
        t.datetime :sihdate
        t.datetime :sildate
        t.string :upd_flag, limit: 1

        t.timestamps null: false
      end
    end
end
