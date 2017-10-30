class RemoveIdAndCreatedAtAndUpdatedAtFromCurrentnav < ActiveRecord::Migration
  def change
    remove_column :currentnavs, :id, :integer
    remove_column :currentnavs, :created_at, :datetime
    remove_column :currentnavs, :updated_at, :datetime
  end
end
