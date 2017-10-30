class AddPrimaryFdCodeToSchemeClassifications < ActiveRecord::Migration
  def change
    add_column :scheme_classifications, :primary_fd_code, :integer
  end
end
