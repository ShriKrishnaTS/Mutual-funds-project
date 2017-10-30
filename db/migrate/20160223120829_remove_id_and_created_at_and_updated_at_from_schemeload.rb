class RemoveIdAndCreatedAtAndUpdatedAtFromSchemeload < ActiveRecord::Migration
  def change
    remove_column :schemeloads, :id, :integer
    remove_column :schemeloads, :created_at, :datetime
    remove_column :schemeloads, :updated_at, :datetime
  end
end
