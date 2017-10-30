class RemoveIdAndCreatedAtAndUpdatedAtFromPortfolioInout < ActiveRecord::Migration
  def change
    remove_column :portfolio_inouts, :id, :integer
    remove_column :portfolio_inouts, :created_at, :datetime
    remove_column :portfolio_inouts, :updated_at, :datetime
  end
end
