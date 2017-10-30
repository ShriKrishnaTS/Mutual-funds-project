class CreateCustMsts < ActiveRecord::Migration
  def change
    create_table :cust_msts do |t|
      t.integer :cust_code, index: true, primary_key: true
      t.string :cust_name, limit: 150
      t.string :sebi_reg_no, limit: 50
      t.string :add1, limit: 150
      t.string :add2, limit: 150
      t.string :add3, limit: 150
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
