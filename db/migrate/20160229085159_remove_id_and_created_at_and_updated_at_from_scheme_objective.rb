class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeObjective < ActiveRecord::Migration
  def change
    remove_column :scheme_objectives, :id, :integer
    remove_column :scheme_objectives, :created_at, :datetime
    remove_column :scheme_objectives, :updated_at, :datetime
  end
end
