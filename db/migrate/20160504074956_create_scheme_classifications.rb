class CreateSchemeClassifications < ActiveRecord::Migration
  def change
    create_table :scheme_classifications do |t|
      t.integer :schemecode, limit: 11
      t.string :s_name, limit: 255
      t.string :classification, limit: 255
      t.decimal :lcap_holdpercentage
      t.decimal :mcap_holdpercentage
      t.decimal :scap_holdpercentage
      t.decimal :avg_mat_num
      t.string :remarks1, limit: 255
      t.string :remarks2, limit: 255
      t.string :remarks3, limit: 255

      t.timestamps null: false
    end
  end
end
