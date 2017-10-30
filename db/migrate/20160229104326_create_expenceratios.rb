class CreateExpenceratios < ActiveRecord::Migration
  def change
    create_table :expenceratios do |t|
      t.integer :amc_code
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :date, index: true, primary_key: true
      t.decimal :exratio
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
