class CreatePePbRatios < ActiveRecord::Migration
  def change
    create_table :pe_pb_ratios do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :monthend
      t.decimal :mcap
      t.decimal :pe
      t.decimal :pb
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
