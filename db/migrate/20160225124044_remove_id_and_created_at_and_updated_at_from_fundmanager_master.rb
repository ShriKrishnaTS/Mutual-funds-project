class RemoveIdAndCreatedAtAndUpdatedAtFromFundmanagerMaster < ActiveRecord::Migration
  def change
    remove_column :fundmanager_masters, :id, :integer
    remove_column :fundmanager_masters, :created_at, :datetime
    remove_column :fundmanager_masters, :updated_at, :datetime
  end
end
