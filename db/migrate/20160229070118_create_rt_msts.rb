class CreateRtMsts < ActiveRecord::Migration
  def change
    create_table :rt_msts do |t|
      t.integer :rt_code, index: true, primary_key: true
      t.string :rt_name, limit: 100
      t.string :sebi_reg_no, limit: 100
      t.string :address1, limit: 150
      t.string :address2, limit: 150
      t.string :address3, limit: 150
      t.string :state, limit: 50
      t.string :tel, limit: 100
      t.string :fax, limit: 50
      t.string :website, limit: 100
      t.string :reg_address, limit: 225
      t.string :email, limit: 255
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
