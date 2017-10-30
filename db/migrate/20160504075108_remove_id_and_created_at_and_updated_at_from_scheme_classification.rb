class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeClassification < ActiveRecord::Migration
  def change
    remove_column :scheme_classifications, :id, :integer
    remove_column :scheme_classifications, :created_at, :datetime
    remove_column :scheme_classifications, :updated_at, :datetime
  end
end
