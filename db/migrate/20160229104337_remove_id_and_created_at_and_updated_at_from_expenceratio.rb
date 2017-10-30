class RemoveIdAndCreatedAtAndUpdatedAtFromExpenceratio < ActiveRecord::Migration
  def change
    remove_column :expenceratios, :id, :integer
    remove_column :expenceratios, :created_at, :datetime
    remove_column :expenceratios, :updated_at, :datetime
  end
end
