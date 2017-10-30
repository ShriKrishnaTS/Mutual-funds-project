class RemoveIdAndCreatedAtAndUpdatedAtFromClassificationMaster < ActiveRecord::Migration
  def change
    remove_column :classification_masters, :id, :integer
    remove_column :classification_masters, :created_at, :datetime
    remove_column :classification_masters, :updated_at, :datetime
  end
end
