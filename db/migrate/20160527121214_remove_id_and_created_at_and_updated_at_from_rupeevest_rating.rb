class RemoveIdAndCreatedAtAndUpdatedAtFromRupeevestRating < ActiveRecord::Migration
  def change
    remove_column :rupeevest_ratings, :id, :integer
    remove_column :rupeevest_ratings, :created_at, :datetime
    remove_column :rupeevest_ratings, :updated_at, :datetime
  end
end
