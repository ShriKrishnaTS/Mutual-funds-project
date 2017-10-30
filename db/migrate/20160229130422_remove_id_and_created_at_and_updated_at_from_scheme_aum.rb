class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeAum < ActiveRecord::Migration
  def change
    remove_column :scheme_aums, :id, :integer
    remove_column :scheme_aums, :created_at, :datetime
    remove_column :scheme_aums, :updated_at, :datetime
  end
end
