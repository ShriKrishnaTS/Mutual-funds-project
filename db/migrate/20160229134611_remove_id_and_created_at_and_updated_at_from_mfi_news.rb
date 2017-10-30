class RemoveIdAndCreatedAtAndUpdatedAtFromMfiNews < ActiveRecord::Migration
  def change
    remove_column :mfi_news, :id, :integer
    remove_column :mfi_news, :created_at, :datetime
    remove_column :mfi_news, :updated_at, :datetime
  end
end
