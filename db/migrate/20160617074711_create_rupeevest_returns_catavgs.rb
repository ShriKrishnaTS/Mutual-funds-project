class CreateRupeevestReturnsCatavgs < ActiveRecord::Migration
  def change
    create_table :rupeevest_returns_catavgs do |t|
      t.integer :classification_id
      t.decimal :avg_year1
      t.decimal :avg_year2
      t.decimal :avg_year3
      t.decimal :avg_year4
      t.decimal :avg_year5
      t.decimal :avg_year6
      t.decimal :avg_year7
      t.decimal :avg_year8
      t.decimal :avg_year9
      t.decimal :avg_year10
      t.decimal :avg_month1
      t.decimal :avg_month2
      t.decimal :avg_month3
      t.decimal :avg_month4
      t.decimal :avg_month5
      t.decimal :avg_month6
      t.decimal :avg_month7
      t.decimal :avg_month8
      t.decimal :avg_month9
      t.decimal :avg_month10
      t.decimal :avg_quarter1
      t.decimal :avg_quarter2
      t.decimal :avg_quarter3
      t.decimal :avg_quarter4
      t.decimal :avg_quarter5
      t.decimal :avg_quarter6
      t.decimal :avg_quarter7
      t.decimal :avg_quarter8
      t.decimal :avg_quarter9
      t.decimal :avg_quarter10

      t.timestamps null: false
    end
  end
end
