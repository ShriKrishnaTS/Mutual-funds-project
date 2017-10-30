class CreateAmcKeypeople < ActiveRecord::Migration
  def change
    create_table :amc_keypeople do |t|
      t.integer :amc_code, index: true, primary_key: true
      t.string :amc_name, limit: 100
      t.integer :srno, index: true, primary_key: true
      t.string :name, limit: 50
      t.string :desg, limit: 50
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
