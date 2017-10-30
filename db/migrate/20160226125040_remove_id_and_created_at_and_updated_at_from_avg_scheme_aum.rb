class RemoveIdAndCreatedAtAndUpdatedAtFromAvgSchemeAum < ActiveRecord::Migration
  def change
    remove_column :avg_scheme_aums, :id, :integer
    remove_column :avg_scheme_aums, :created_at, :datetime
    remove_column :avg_scheme_aums, :updated_at, :datetime
  end
end
