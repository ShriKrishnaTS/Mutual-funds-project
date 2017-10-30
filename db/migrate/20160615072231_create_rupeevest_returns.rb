class CreateRupeevestReturns < ActiveRecord::Migration
  def change
    create_table :rupeevest_returns do |t|
      t.integer :schemecode
      t.decimal :return_year1
      t.decimal :return_year2
      t.decimal :return_year3
      t.decimal :return_year4
      t.decimal :return_year5
      t.decimal :return_year6
      t.decimal :return_year7
      t.decimal :return_year8
      t.decimal :return_year9
      t.decimal :return_year10
      t.integer :rank_year1
      t.integer :rank_year2
      t.integer :rank_year3
      t.integer :rank_year4
      t.integer :rank_year5
      t.integer :rank_year6
      t.integer :rank_year7
      t.integer :rank_year8
      t.integer :rank_year9
      t.integer :rank_year10
      t.decimal :return_month1
      t.decimal :return_month2
      t.decimal :return_month3
      t.decimal :return_month4
      t.decimal :return_month5
      t.decimal :return_month6
      t.decimal :return_month7
      t.decimal :return_month8
      t.decimal :return_month9
      t.decimal :return_month10
      t.integer :rank_month1
      t.integer :rank_month2
      t.integer :rank_month3
      t.integer :rank_month4
      t.integer :rank_month5
      t.integer :rank_month6
      t.integer :rank_month7
      t.integer :rank_month8
      t.integer :rank_month9
      t.integer :rank_month10
      t.decimal :return_quarter1
      t.decimal :return_quarter2
      t.decimal :return_quarter3
      t.decimal :return_quarter4
      t.decimal :return_quarter5
      t.decimal :return_quarter6
      t.decimal :return_quarter7
      t.decimal :return_quarter8
      t.decimal :return_quarter9
      t.decimal :return_quarter10
      t.integer :rank_quarter1
      t.integer :rank_quarter2
      t.integer :rank_quarter3
      t.integer :rank_quarter4
      t.integer :rank_quarter5
      t.integer :rank_quarter6
      t.integer :rank_quarter7
      t.integer :rank_quarter8
      t.integer :rank_quarter9
      t.integer :rank_quarter10

      t.timestamps null: false
    end
  end
end
