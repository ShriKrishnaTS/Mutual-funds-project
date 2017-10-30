class CreateMfSips < ActiveRecord::Migration
  def change
    create_table :mf_sips do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :amc_code
      t.string :frequency, index: true, primary_key: true, limit: 100
      t.string :sip, limit: 1
      t.string :sipdates, limit: 255
      t.integer :sipdays1
      t.integer :sipdays2
      t.integer :sipdays3
      t.integer :sipdays4
      t.integer :sipdays5
      t.integer :sipdays6
      t.integer :sipdays7
      t.decimal :sipmininvest
      t.decimal :sipaddninvest
      t.integer :sipfrequencyno
      t.decimal :maxentryload
      t.decimal :maxexitload
      t.string :entry_remark, limit: 1000
      t.string :exit_remark, limit: 1000
      t.string :note
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
