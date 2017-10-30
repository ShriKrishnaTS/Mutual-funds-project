class CreateMcapClassifications < ActiveRecord::Migration
  def change
    create_table :mcap_classifications do |t|
      t.integer :ps_code, limit: 11
      t.decimal :mcap_company
      t.string :classification, limit: 5
      t.string :remarks1, limit: 100
      t.string :remarks2, limit: 100
      t.string :remarks3, limit: 100

      t.timestamps null: false
    end
  end
end
