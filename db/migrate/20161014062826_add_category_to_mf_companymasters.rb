class AddCategoryToMfCompanymasters < ActiveRecord::Migration
  def change
    add_column :mf_companymasters, :category, :string
  end
end
