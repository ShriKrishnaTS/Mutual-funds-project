class RemoveIdAndCreatedAtAndUpdatedAtFromNavhistfullAdjnav < ActiveRecord::Migration
  def change
    remove_column :navhistfull_adjnavs, :id, :integer
    remove_column :navhistfull_adjnavs, :created_at, :datetime
    remove_column :navhistfull_adjnavs, :updated_at, :datetime
  end
end
