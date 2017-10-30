class RemoveIdAndCreatedAtAndUpdatedAtFromMfRatios < ActiveRecord::Migration
  def change
    remove_column :mf_ratios, :id, :integer
    remove_column :mf_ratios, :created_at, :datetime
    remove_column :mf_ratios, :updated_at, :datetime
  end
end
