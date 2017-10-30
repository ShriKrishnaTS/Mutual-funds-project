class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeIndex < ActiveRecord::Migration
  def change
    remove_column :scheme_indices, :id, :integer
    remove_column :scheme_indices, :created_at, :datetime
    remove_column :scheme_indices, :updated_at, :datetime
  end
end
