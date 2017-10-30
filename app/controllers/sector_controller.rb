class SectorController < ApplicationController

	def sector
		
		begin
				
			@sector = ActiveRecord::Base.connection.select_all("SELECT `dec_15`,`dec_15`,`sep_15`,`jun_15`,`mar_15`,`schemecode` FROM `sectors` WHERE `schemecode` = 2")
			
			 respond_to do |format|
			 format.json { 
			   render json: {:sector => @sector}
			   } 
			end
		rescue =>err
			 puts err.message
		end 
	end
end
