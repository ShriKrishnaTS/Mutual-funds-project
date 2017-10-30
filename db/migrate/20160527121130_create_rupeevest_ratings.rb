class CreateRupeevestRatings < ActiveRecord::Migration
  def change
    create_table :rupeevest_ratings do |t|
      t.integer :schemecode, index: true, primary_key: true
      t.decimal :total_return
      t.decimal :consistency_of_return
      t.decimal :risk
      t.decimal :cost_factor
      t.decimal :portfolio_attributes
      t.decimal :rupeevest_rating

      t.timestamps null: false
    end
  end
end
