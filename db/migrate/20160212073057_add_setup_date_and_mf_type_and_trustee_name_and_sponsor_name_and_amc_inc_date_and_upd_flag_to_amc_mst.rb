class AddSetupDateAndMfTypeAndTrusteeNameAndSponsorNameAndAmcIncDateAndUpdFlagToAmcMst < ActiveRecord::Migration
  def change
    add_column :amc_msts, :setup_date, :datetime
    add_column :amc_msts, :mf_type, :string, limit: 50
    add_column :amc_msts, :trustee_name, :string, limit: 100
    add_column :amc_msts, :sponsor_name, :string, limit: 255
    add_column :amc_msts, :amc_inc_date, :datetime
    add_column :amc_msts, :upd_flag, :string, limit: 1
  end
end
