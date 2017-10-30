class CreateCreditRatings < ActiveRecord::Migration
  def change
    create_table :credit_ratings do |t|
      t.string :accord_display_name
      t.string :rupeevest_display_name
      t.string :rupeevest_group

      t.timestamps null: false
    end
  end
end
