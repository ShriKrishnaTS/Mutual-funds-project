class CreatePortfolioMarketcaps < ActiveRecord::Migration
  def change
    create_table :portfolio_marketcaps do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.string :portfolio_marketcap
      t.decimal :fund
      t.decimal :category_avg

      t.timestamps null: false
    end
  end
end
