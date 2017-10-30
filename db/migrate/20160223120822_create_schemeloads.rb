class CreateSchemeloads < ActiveRecord::Migration
  def change
    create_table :schemeloads do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :ldate, index: true, primary_key: true
      t.integer :ltypecode, index: true, primary_key: true
      t.integer :lsrno, index: true, primary_key: true
      t.decimal :frmamount
      t.decimal :uptoamount
      t.integer :minperiod
      t.integer :maxperiod
      t.string :min, limit: 20
      t.string :max, limit: 20
      t.decimal :entryload
      t.decimal :exitload
      t.string :remarks, limit: 1024
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
