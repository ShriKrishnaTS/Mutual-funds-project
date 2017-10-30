class CreatePortfolioHoldings < ActiveRecord::Migration
  def change
    create_table :portfolio_holdings do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.string :sect_name, limit: 255
      t.string :asect_name, limit: 255
      t.string :rating, limit: 255
      t.decimal :weight

      t.timestamps null: false
    end
  end
end
