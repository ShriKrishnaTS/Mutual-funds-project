class CreateFvchanges < ActiveRecord::Migration
  def change
    create_table :fvchanges do |t|
      t.integer :amc_code
      t.integer :schemecode, index: true, primary_key: true
      t.string :scheme_name, limit: 255
      t.decimal :fvbefore
      t.decimal :fvafter
      t.datetime :fvdate, index: true, primary_key: true
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
