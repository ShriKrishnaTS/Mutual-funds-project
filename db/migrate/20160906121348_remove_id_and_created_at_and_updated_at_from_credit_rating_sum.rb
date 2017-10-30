class RemoveIdAndCreatedAtAndUpdatedAtFromCreditRatingSum < ActiveRecord::Migration
  def change
    remove_column :credit_rating_sums, :id, :integer
    remove_column :credit_rating_sums, :created_at, :datetime
    remove_column :credit_rating_sums, :updated_at, :datetime
  end
end
