class RemoveIdAndCreatedAtAndUpdatedAtFromMfSips < ActiveRecord::Migration
  def change
    remove_column :mf_sips, :id, :integer
    remove_column :mf_sips, :created_at, :datetime
    remove_column :mf_sips, :updated_at, :datetime
  end
end
