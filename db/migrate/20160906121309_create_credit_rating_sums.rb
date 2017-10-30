class CreateCreditRatingSums < ActiveRecord::Migration
  def change
    create_table :credit_rating_sums do |t|
      t.integer :schemecode
      t.string :classification
      t.datetime :invdate
      t.decimal :holdpercentage
      t.string :rupeevest_display_name

      t.timestamps null: false
    end
  end
end
