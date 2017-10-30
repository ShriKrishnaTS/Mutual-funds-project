class CreateSchemeIndices < ActiveRecord::Migration
  def change
    create_table :scheme_indices do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.integer :indexcode, index: true, primary_key: true
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
