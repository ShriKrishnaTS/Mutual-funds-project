class RemoveIdAndCreatedAtAndUpdatedAtFromMfCompanymaster < ActiveRecord::Migration
  def change
    remove_column :mf_companymasters, :id, :integer
    remove_column :mf_companymasters, :created_at, :datetime
    remove_column :mf_companymasters, :updated_at, :datetime
  end
end
