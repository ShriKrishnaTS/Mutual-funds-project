class RemoveIdAndCreatedAtAndUpdatedAtFromCreditRating < ActiveRecord::Migration
  def change
    remove_column :credit_ratings, :id, :integer
    remove_column :credit_ratings, :created_at, :datetime
    remove_column :credit_ratings, :updated_at, :datetime
  end
end
