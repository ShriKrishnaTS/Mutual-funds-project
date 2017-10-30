class AddSrnoAndOfficeTypeAndAdd1AndAdd2AndAdd3AndEmailAndPhoneAndFaxAndWebsiteToAmcMst < ActiveRecord::Migration
  def change
    add_column :amc_msts, :srno, :integer
    add_column :amc_msts, :office_type, :string, limit: 60
    add_column :amc_msts, :add1, :string, limit: 100
    add_column :amc_msts, :add2, :string, limit: 100
    add_column :amc_msts, :add3, :string, limit: 100
    add_column :amc_msts, :email, :string, limit: 60
    add_column :amc_msts, :phone, :string, limit: 50
    add_column :amc_msts, :fax, :string, limit: 50
    add_column :amc_msts, :website, :string, limit: 100
  end
end
