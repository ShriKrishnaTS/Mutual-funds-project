class RemoveIdAndCreatedAtAndUpdatedAtFromMfStp < ActiveRecord::Migration
  def change
    remove_column :mf_stps, :id, :integer
    remove_column :mf_stps, :created_at, :datetime
    remove_column :mf_stps, :updated_at, :datetime
  end
end
