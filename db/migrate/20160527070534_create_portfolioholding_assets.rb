class CreatePortfolioholdingAssets < ActiveRecord::Migration
  def change
    create_table :portfolioholding_assets do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.string :company, limit: 255
      t.string :sector, limit: 255
      t.string :credit_rating, limit: 255
      t.decimal :assets
      t.decimal :previous_quater

      t.timestamps null: false
    end
  end
end
