class RemoveIdAndCreatedAtAndUpdatedAtFromAsectMstNew < ActiveRecord::Migration
  def change
    remove_column :asect_mst_news, :id, :integer
    remove_column :asect_mst_news, :created_at, :datetime
    remove_column :asect_mst_news, :updated_at, :datetime
  end
end
