class PortfolioHoldingsController < ApplicationController

	def portfolio_holdings

		begin
			@portfolio_hold = ActiveRecord::Base.connection.select_all ("SELECT 'schemecode', `sect_name`,`asect_name`,`rating`,`holdpercentage` as weight FROM `mf_portfolios' " )
    				
			respond_to do |format|
			     format.json { 
				   render json: {:portfolio_hold => @portfolio_hold}
			       } 
				end
		rescue =>err
			puts err.message
		end
        
    end 
end
