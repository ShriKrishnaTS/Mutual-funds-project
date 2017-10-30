class RemoveIdAndCreatedAtAndUpdatedAtFromMfSwp < ActiveRecord::Migration
  def change
    remove_column :mf_swps, :id, :integer
    remove_column :mf_swps, :created_at, :datetime
    remove_column :mf_swps, :updated_at, :datetime
  end
end
