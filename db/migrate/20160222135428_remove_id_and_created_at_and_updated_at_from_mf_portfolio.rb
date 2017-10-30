class RemoveIdAndCreatedAtAndUpdatedAtFromMfPortfolio < ActiveRecord::Migration
  def change
    remove_column :mf_portfolios, :id, :integer
    remove_column :mf_portfolios, :created_at, :datetime
    remove_column :mf_portfolios, :updated_at, :datetime
  end
end
