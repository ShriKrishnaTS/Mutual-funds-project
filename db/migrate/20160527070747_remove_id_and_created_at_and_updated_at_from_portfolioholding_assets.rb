class RemoveIdAndCreatedAtAndUpdatedAtFromPortfolioholdingAssets < ActiveRecord::Migration
  def change
    remove_column :portfolioholding_assets, :id, :integer
    remove_column :portfolioholding_assets, :created_at, :datetime
    remove_column :portfolioholding_assets, :updated_at, :datetime
  end
end
