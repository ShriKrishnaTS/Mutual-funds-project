class AddAmcCodeAndAmcAndFundToAmcMst < ActiveRecord::Migration
  def change
    add_column :amc_msts, :amc_code, :integer, index: true, primary_key: true
    add_column :amc_msts, :amc, :string, limit: 100
    add_column :amc_msts, :fund, :string, limit: 100
  end
end
