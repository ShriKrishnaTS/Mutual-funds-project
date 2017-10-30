class CreateSchemeObjectives < ActiveRecord::Migration
  def change
    create_table :scheme_objectives do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.string :objective, limit: 1024
      t.string :upd_flag, limit: 1

      t.timestamps null: false
    end
  end
end
