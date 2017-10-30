class RemoveIdAndCreatedAtAndUpdatedAtFromMfAnsReturn < ActiveRecord::Migration
  def change
    remove_column :mf_ans_returns, :id, :integer
    remove_column :mf_ans_returns, :created_at, :datetime
    remove_column :mf_ans_returns, :updated_at, :datetime
  end
end
