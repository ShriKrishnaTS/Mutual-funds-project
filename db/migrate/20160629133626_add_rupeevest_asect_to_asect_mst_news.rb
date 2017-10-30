class AddRupeevestAsectToAsectMstNews < ActiveRecord::Migration
  def change
    add_column :asect_mst_news, :rupeevest_asect, :string
  end
end
