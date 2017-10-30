class AddTypeToClassificationMaster < ActiveRecord::Migration
  def change
    add_column :classification_masters, :type, :string
  end
end
