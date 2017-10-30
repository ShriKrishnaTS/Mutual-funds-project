class FundComparisionController < ApplicationController

def get_compare_value


		begin

		# @comp = ActiveRecord::Base.connection.select_all("SELECT sr.`schemecode`,ty.type, sr.`expenceratio`, sr.`fund_manager`, sr.`navchange`, sr.`turnover_ratio`, max(round(sr.`sdx_returns`,2)) as `sdx_returns`, max(round(sr.`sharpex_returns`,2)) as `sharpex_returns`, max(round(sr.`sotinox_returns`,2)) as `sotinox_returns`, max(round(sr.`betax_returns`,2)) as `betax_returns`, max(round(sr.`alphax_returns`, 2)) as `alphax_returns`, sr.`exitload`, sr.`navrs`,date_format( sr.`navdate`, '%Y-%m-%d' ) AS `navdate` , sr.`lockperiod`, date_format( sr.`inception_date`, '%Y-%m-%d' ) AS `inception_date`, sr.`inception_return`, sr.`minimum_investment`, sr.`aumtotal`, sr.`fund_house`, sr.`index_name`, sr.`redemption_period`, rr.`portfolio_attributes`, rr.`cost_factor`, rr.`risk`, rr.`consistency_of_return`, rr.`total_return`,sc.`s_name`, sc.`classification` from scheme_rupeevests sr join rupeevest_ratings rr on sr.schemecode = rr.schemecode join scheme_details_fulls sd on sr.schemecode = sd.schemecode join type_msts ty on sd.type_code = ty.type_code  join scheme_classifications sc on sr.`schemecode`=  sc.`schemecode` where sr.schemecode = 15")

		@comp = ActiveRecord::Base.connection.select_all("SELECT sr.`schemecode`,ty.type, sr.`expenceratio`, sr.`fund_manager`, sr.`navchange`, sr.`turnover_ratio`, round(sr.`sdx_returns`,2) `sdx_returns`, round(sr.`sharpex_returns`,2) `sharpex_returns`, round(sr.`sotinox_returns`,2) `sotinox_returns`, round(sr.`betax_returns`,2) `betax_returns`,round(sr.`alphax_returns`, 2) `alphax_returns`, sr.`exitload`, round(sr.`navrs`,2) as navrs,date_format( sr.`navdate`, '%Y-%m-%d' ) AS `navdate` , sr.`lockperiod`, date_format( sr.`inception_date`, '%Y-%m-%d' ) AS `inception_date`, sr.`inception_return`, sr.`minimum_investment`, sr.`aumtotal`, sr.`fund_house`, sr.`index_name`, sr.`redemption_period`, rr.`portfolio_attributes`, rr.`cost_factor`, rr.`risk`,rr.`rupeevest_rating`, rr.`consistency_of_return`, rr.`total_return`,sc.`s_name`,sc.`classification`,round(sc.lcap_holdpercentage,2) lcap, round(sc.mcap_holdpercentage,2) mcap,round(sc.scap_holdpercentage,2) scap,case when pp.mcap is null then '-' else round(pp.mcap,2)  end ppmcap, case when pp.pe is null then '-' else pp.pe end pe,case when pp.pb is null then '-' else pp.pb end pb , round(rrs.`return_year1`,2) as one_y,round(rrs.`return_year2`,2) as two_y, round(rrs.`return_year3`,2) as three_y,round( rrs.`return_month6`,2) as six_m  from scheme_rupeevests sr join rupeevest_ratings rr on sr.schemecode = rr.schemecode join scheme_details_fulls sd on sr.schemecode = sd.schemecode join type_msts ty on sd.type_code = ty.type_code join scheme_classifications sc on sr.`schemecode`= sc.`schemecode` join (select max(monthend),schemecode,mcap,pe,pb from pe_pb_ratios where schemecode in (#{params[:ids]}) group by schemecode) pp on sr.schemecode = pp.schemecode join rupeevest_returns rrs on sr.schemecode = rrs.schemecode  where sr.schemecode in (#{params[:ids]}) ORDER BY sr.schemecode desc")
		  respond_to do |format|
			 format.json {
				render json: {:comp => @comp}
			 }
		   end
		rescue =>err
			puts err.message
		end
   end
end
