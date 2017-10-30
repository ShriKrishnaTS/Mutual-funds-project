class CreateMfSwps < ActiveRecord::Migration
  def change
    create_table :mf_swps do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :amc_code
      t.string :frequency, index: true, primary_key: true, limit: 100
      t.string :swp, limit: 1
      t.string :swpdates, limit: 255
      t.integer :swpdays1
      t.integer :swpdays2
      t.integer :swpdays3
      t.integer :swpdays4
      t.integer :swpdays5
      t.integer :swpdays6
      t.integer :swpdays7
      t.decimal :swpmininvest
      t.decimal :swpaddninvest
      t.integer :swpfrequencyno
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
