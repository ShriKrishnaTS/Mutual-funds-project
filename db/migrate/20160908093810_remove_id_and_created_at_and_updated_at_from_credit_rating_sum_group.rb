class RemoveIdAndCreatedAtAndUpdatedAtFromCreditRatingSumGroup < ActiveRecord::Migration
  def change
    remove_column :credit_rating_sum_groups, :id, :integer
    remove_column :credit_rating_sum_groups, :created_at, :datetime
    remove_column :credit_rating_sum_groups, :updated_at, :datetime
  end
end
