class RemoveIdAndCreatedAtAndUpdatedAtFromNavgraph < ActiveRecord::Migration
  def change
    remove_column :navgraphs, :id, :integer
    remove_column :navgraphs, :created_at, :datetime
    remove_column :navgraphs, :updated_at, :datetime
  end
end
