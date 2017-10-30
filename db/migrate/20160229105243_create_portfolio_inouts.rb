class CreatePortfolioInouts < ActiveRecord::Migration
  def change
    create_table :portfolio_inouts do |t|
      t.integer :fincode, index: true, primary_key: true
      t.datetime :invdate
      t.string :mode, limit: 5
      t.string :compname, limit: 100
      t.string :s_name, limit: 50
      t.decimal :mkt_value
      t.decimal :noshares
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
