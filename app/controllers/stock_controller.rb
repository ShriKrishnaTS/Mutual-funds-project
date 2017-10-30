class StockController < ApplicationController

	def stock
		
		begin
				
			@stock = ActiveRecord::Base.connection.select_all("SELECT `schemecode`,`fund`,`dec_15`,`sep_15`,`jun_15`,`mar_15` FROM `stocks` WHERE `schemecode` = 2")
			
			 respond_to do |format|
			 format.json { 
			   render json: {:stock => @stock}
			   } 
			end
			 rescue =>err
		end
	end
end
