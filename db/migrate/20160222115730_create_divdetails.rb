class CreateDivdetails < ActiveRecord::Migration
  def change
    create_table :divdetails do |t|
      t.integer :amc_code
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :recorddate, index: true, primary_key: true
      t.integer :div_code
      t.datetime :exdivdate
      t.decimal :bonusrate1
      t.decimal :bonusrate2
      t.decimal :gross
      t.decimal :corporate
      t.decimal :noncorporate
      t.string :status, limit: 10
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
