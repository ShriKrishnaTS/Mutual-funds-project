class RemoveIdAndCreatedAtAndUpdatedAtFromMcapClassification < ActiveRecord::Migration
  def change
    remove_column :mcap_classifications, :id, :integer
    remove_column :mcap_classifications, :created_at, :datetime
    remove_column :mcap_classifications, :updated_at, :datetime
  end
end
