class RemoveIdAndCreatedAtAndUpdatedAtFromPortfolioHolding < ActiveRecord::Migration
  def change
    remove_column :portfolio_holdings, :id, :integer
    remove_column :portfolio_holdings, :created_at, :datetime
    remove_column :portfolio_holdings, :updated_at, :datetime
  end
end
