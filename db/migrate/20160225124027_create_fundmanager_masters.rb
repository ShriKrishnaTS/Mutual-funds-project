class CreateFundmanagerMasters < ActiveRecord::Migration
  def change
    create_table :fundmanager_masters do |t|
      t.integer :fmid, index: true, primary_key: true
      t.string :initial, limit: 10
      t.string :fundmanager, limit: 200
      t.string :qualification, limit: 200
      t.string :experience, limit: 200
      t.string :basicdetails, limit: 1000
      t.string :designation, limit: 100
      t.integer :age
      t.datetime :reporteddate
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
