class CreateCreditRatingSumGroups < ActiveRecord::Migration
  def change
    create_table :credit_rating_sum_groups do |t|
      t.integer :schemecode
      t.string :classification
      t.datetime :invdate
      t.decimal :holdpercentage
      t.string :rupeevest_group

      t.timestamps null: false
    end
  end
end
