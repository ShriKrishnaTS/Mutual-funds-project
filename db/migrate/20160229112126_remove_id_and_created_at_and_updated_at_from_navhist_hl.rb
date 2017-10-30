class RemoveIdAndCreatedAtAndUpdatedAtFromNavhistHl < ActiveRecord::Migration
  def change
    remove_column :navhist_hls, :id, :integer
    remove_column :navhist_hls, :created_at, :datetime
    remove_column :navhist_hls, :updated_at, :datetime
  end
end
