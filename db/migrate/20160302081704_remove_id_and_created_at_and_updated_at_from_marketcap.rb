class RemoveIdAndCreatedAtAndUpdatedAtFromMarketcap < ActiveRecord::Migration
  def change
    remove_column :marketcaps, :id, :integer
    remove_column :marketcaps, :created_at, :datetime
    remove_column :marketcaps, :updated_at, :datetime
  end
end
