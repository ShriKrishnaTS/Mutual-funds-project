class RemoveIdAndCreatedAtAndUpdatedAtFromPortfolioMarketcap < ActiveRecord::Migration
  def change
    remove_column :portfolio_marketcaps, :id, :integer
    remove_column :portfolio_marketcaps, :created_at, :datetime
    remove_column :portfolio_marketcaps, :updated_at, :datetime
  end
end
