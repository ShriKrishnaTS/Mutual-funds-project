class RemoveIdAndCreatedAtAndUpdatedAtFromIndustrymaster < ActiveRecord::Migration
  def change
    remove_column :industrymasters, :id, :integer
    remove_column :industrymasters, :created_at, :datetime
    remove_column :industrymasters, :updated_at, :datetime
  end
end
