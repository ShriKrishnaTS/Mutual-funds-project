class CreateMfStps < ActiveRecord::Migration
  def change
    create_table :mf_stps do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :amc_code
      t.string :frequency, index: true, primary_key: true, limit: 100
      t.string :stpinout, index: true, primary_key: true, limit: 1
      t.string :stp, limit: 1
      t.string :stpfrequency, limit: 20
      t.string :stpdates, limit: 225
      t.integer :stpdays1
      t.integer :stpdays2
      t.integer :stpdays3
      t.integer :stpdays4
      t.integer :stpdays5
      t.integer :stpdays6
      t.integer :stpdays7
      t.decimal :stpmininvest
      t.decimal :stpaddninvest
      t.integer :stpfrequencyno
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
