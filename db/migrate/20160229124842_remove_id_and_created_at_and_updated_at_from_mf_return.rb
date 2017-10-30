class RemoveIdAndCreatedAtAndUpdatedAtFromMfReturn < ActiveRecord::Migration
  def change
    remove_column :mf_returns, :id, :integer
    remove_column :mf_returns, :created_at, :datetime
    remove_column :mf_returns, :updated_at, :datetime
  end
end
