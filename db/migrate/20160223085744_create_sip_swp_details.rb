class CreateSipSwpDetails < ActiveRecord::Migration
  def change
    create_table :sip_swp_details do |t|
      t.integer :schemecode
      t.integer :amc_code
      t.integer :sipdays1
      t.integer :sipdays2
      t.integer :sipdays3
      t.integer :sipdays4
      t.integer :sipdays5
      t.integer :sipdays6
      t.integer :sipdays7
      t.string :sipdaysall, limit: 20
      t.string :sipfrequency, limit: 20
      t.decimal :sipmininvest
      t.decimal :sipaddninvest
      t.integer :sipfrequencyno
      t.integer :swpdays1
      t.integer :swpdays2
      t.integer :swpdays3
      t.integer :swpdays4
      t.integer :swpdays5
      t.integer :swpdays6
      t.integer :swpdays7
      t.string :swpdaysall, limit: 20
      t.string :swpfrequecy, limit: 20
      t.decimal :swpmininvest
      t.decimal :swpaddninvest
      t.integer :swpfrequencyno
      t.decimal :maxentryload
      t.decimal :maxexitload
      t.text :entry_remark
      t.text :exit_remark
      t.text :note
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
