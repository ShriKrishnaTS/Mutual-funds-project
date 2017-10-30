class RemoveIdAndCreatedAtAndUpdatedAtFromMfAbsReturn < ActiveRecord::Migration
  def change
    remove_column :mf_abs_returns, :id, :integer
    remove_column :mf_abs_returns, :created_at, :datetime
    remove_column :mf_abs_returns, :updated_at, :datetime
  end
end
