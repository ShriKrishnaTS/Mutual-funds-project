class CreateMfPortfolios < ActiveRecord::Migration
  def change
    create_table :mf_portfolios do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.datetime :invdate, index: true, primary_key: true
      t.datetime :invenddate
      t.integer :srno, index: true, primary_key: true
      t.integer :fincode
      t.integer :asect_code
      t.integer :sect_code
      t.integer :noshares
      t.decimal :mktval
      t.decimal :aum
      t.decimal :holdpercentage
      t.string :compname, limit: 255
      t.string :sect_name, limit: 255
      t.string :asect_name, limit: 255
      t.string :rating, limit: 100
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
