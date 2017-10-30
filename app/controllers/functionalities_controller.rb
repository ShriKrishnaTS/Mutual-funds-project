class FunctionalitiesController < ApplicationController

	def get_scheme_name

		begin

		 @scheme_name = ActiveRecord::Base.connection.select_all("SELECT `s_name` FROM `scheme_details_fulls` WHERE `schemecode` = 2")
		  respond_to do |format|
			 format.json {
				render json: {:scheme_name => @scheme_name}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end


	def get_current_nav_value

		begin

		 @current_nav = ActiveRecord::Base.connection.select_all("SELECT date_format(`navdate`,'%d-%b-%Y') as navdate , `navrs` , `change` AS navchange FROM `currentnavs` WHERE `schemecode` = 2")
		  respond_to do |format|
			 format.json {
				render json: {:current_nav => @current_nav}
			 }
		   end
		rescue =>err
			puts err.message
		end
   end

   def get_fund_manager

		begin

		 @fund_manager = ActiveRecord::Base.connection.select_all("SELECT `fundmanager` FROM `fundmanager_masters` WHERE `fmid` = 2")
		  respond_to do |format|
			 format.json {
				render json: {:fund_manager => @fund_manager}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_inception_date

		begin

		 @inception_date = ActiveRecord::Base.connection.select_all("SELECT date_format(`incdate`,'%d-%b-%Y') as incdate FROM `mf_abs_returns` WHERE `schemecode` = 2")
		  respond_to do |format|
			 format.json {
				render json: {:inception_date => @inception_date}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_amc_msts

		begin

		 @Amc_name = ActiveRecord::Base.connection.select_all("SELECT am.amc_code, am.fund, dd.corporate, ma.dayret_1, ma.weekret_1, ma.monthret_1 FROM amc_msts am JOIN divdetails dd ON am.amc_code = dd.amc_code JOIN mf_abs_returns ma ON dd.schemecode = ma.schemecode")
		 #puts @Amc_name
		  respond_to do |format|
			 format.json {
				render json: {:Amc_name => @Amc_name}
			 }
		   end
		rescue =>err
		  puts err.message
		end
	end

	def get_aum_totalvalue

		begin

		 @aum_totalvalue = ActiveRecord::Base.connection.select_all("SELECT `schemecode`, sum(`total`) as aumtotal FROM `scheme_aums` WHERE `schemecode` = 1")
		  respond_to do |format|
			 format.json {
				render json: {:aum_totalvalue => @aum_totalvalue}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_exit_load

    begin

     @exit_load = ActiveRecord::Base.connection.select_all("SELECT max(exitload) as exitload FROM `schemeloads` where `schemecode` = 14")
       #puts @inception_return
  respond_to do |format|
     format.json {
        render json: {:exit_load => @exit_load}
     }
   end
    rescue =>err
    puts err.message
    end
end


	def get_expense_ratio

		begin
			@expense_ratio = ActiveRecord::Base.connection.select_all("SELECT max(exratio) as exratio  FROM `expenceratios`where `schemecode` = 2")
			#puts @expense_ratio
			respond_to do |format|
			 format.json {
				render json: {:expense_ratio => @expense_ratio}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_fund_data

		begin
			@fund_data = ActiveRecord::Base.connection.select_all("SELECT sc.`schemecode`,sc.`s_name`,sc.`classification`,mr.`yrret_1`,mr.`yearret_3`,mr.`yearret_5`,sa.`total` FROM `scheme_classifications` sc JOIN `mf_returns` mr ON sc.`schemecode` = mr.`schemecode` JOIN scheme_aums sa ON sc.`schemecode` = sa.`schemecode`  WHERE sc.`classification` = 'Equity : Large Cap' AND DATE_FORMAT( sa.`date`, '%Y-%m-%d' ) = DATE_FORMAT( '2015-12-31', '%Y-%m-%d' )")
		  respond_to do |format|
			 format.json {
				render json: {:fund_data => @fund_data}
			 }
		   end

		rescue => err
			puts err.message
		end
	end

	def get_inception_return

		begin

			@inception_return = ActiveRecord::Base.connection.select_all("SELECT max(`incret`) as incret FROM `bm_indices_res` WHERE `index_code` = 11000")
			#puts @inception_return
			respond_to do |format|
				format.json {
				render json: {:inception_return => @inception_return}
			}
	   end
	   rescue =>err
			puts err.message
	   end

	end


	def get_turnover_ratio

		begin
			@turnover_rati = ActiveRecord::Base.connection.select_all("SELECT max(`turnover_ratio`) as turnover_ratio FROM `avg_maturities` WHERE 'schemecode' = 10 ")
			#puts @turnover_rati


			respond_to do |format|
			 format.json {
				render json: {:turnover_rati => @turnover_rati}
			 }
			end
		rescue =>err
			puts err.message
		end
	end


	def get_minimum_investment

		begin
			@minimum_invest = ActiveRecord::Base.connection.select_all("SELECT max(`mininv`) as mininv FROM `scheme_assetallocs` WHERE `schemecode` = 12")
			#puts @minimum_invest


			  respond_to do |format|
				 format.json {
					render json: {:minimum_invest => @minimum_invest}
				 }
			   end
		rescue =>err
			puts err.message
		end
	end

	def get_onemonth_return

		begin

		@onemonth_ret = ActiveRecord::Base.connection.select_all("SELECT monthret_1 FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @onemonth_ret


		  respond_to do |format|
			 format.json {
				render json: {:onemonth_ret => @onemonth_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_threemonth_return

		begin

		@threemonth_ret = ActiveRecord::Base.connection.select_all("SELECT `monthret_3` FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @threemonth_ret


		  respond_to do |format|
			 format.json {
				render json: {:threemonth_ret => @threemonth_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_sixmonth_return

		begin

		@sixmonth_ret = ActiveRecord::Base.connection.select_all("SELECT `monthret_6` FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @sixmonth_ret


		  respond_to do |format|
			 format.json {
				render json: {:sixmonth_ret => @sixmonth_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_oneyear_return

		begin

		@oneyear_ret = ActiveRecord::Base.connection.select_all("SELECT `yrret_1` FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @oneyear_ret


		  respond_to do |format|
			 format.json {
				render json: {:oneyear_ret => @oneyear_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_twoyear_return

		begin

		@twoyear_ret = ActiveRecord::Base.connection.select_all("SELECT `yearret_2` FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @twoyear_ret


		  respond_to do |format|
			 format.json {
				render json: {:twoyear_ret => @twoyear_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_threeyear_return

		begin

		@threeyear_ret = ActiveRecord::Base.connection.select_all("SELECT `yearret_3` FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @threeyear_ret


		  respond_to do |format|
			 format.json {
				render json: {:threeyear_ret => @threeyear_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_fiveyear_return

		begin

		@fiveyear_ret = ActiveRecord::Base.connection.select_all("SELECT `yearret_5` FROM `mf_returns` WHERE `schemecode`= 2")
		#puts @fiveyear_ret


		  respond_to do |format|
			 format.json {
				render json: {:fiveyear_ret => @fiveyear_ret}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def schemedata_landing

		begin
		@schemedata = ActiveRecord::Base.connection.select_all("SELECT sr.`schemecode`, round(sr.`returns_1month`, 2) as returns_1month ,round( sr.`returns_3month`, 2) as returns_3month, round( sr.`returns_1year`,2) as returns_1year ,round(sr.`returns_3year`,2) as returns_3year , round(sr.`returns_5year`,2) as returns_5year , sr.`expenceratio`, sr.`turnover_ratio`, sr.`exitload`, round(sr.`navrs`,2) as navrs , sr.`inception_date`, sr.`minimum_investment`, round(sr.`aumtotal`, 2) as aumtotal , round(sr.`betax_returns`, 2) as betax_returns, round( sr.`alphax_returns`,2) as alphax_returns ,round( sr.`sotinox_returns`,2) as sotinox_returns, round(sr.`sharpex_returns`,2) as sharpex_returns , round( sr.`sdx_returns`,2) as sdx_returns ,sr.fund_manager, sc.`s_name`, rr.`rupeevest_rating`, rr.`portfolio_attributes`, rr.`cost_factor`, rr.`risk`, rr.`consistency_of_return`, rr.`total_return`, max( rsh.`hold_perc` ) hold_perc, rs.rv_sect_name highest_sector from scheme_rupeevests sr join scheme_classifications sc on sr.`schemecode`=  sc.`schemecode` join rupeevest_ratings rr on sr.schemecode = rr.schemecode  left join `rupeevest_sect_holdpercs` rsh on sr.schemecode = rsh.schemecode left JOIN rupeevest_sectors rs ON rsh.rv_sect_code = rs.rv_sect_code where sc.`classification`= 'Equity : Large Cap' group by sr.schemecode")

		#@schemedata = ActiveRecord::Base.connection.select_all("SELECT sr.`schemecode`, round(sr.`returns_1month`, 2) as returns_1month ,round( sr.`returns_3month`, 2) as returns_3month, round( sr.`returns_1year`,2) as returns_1year ,round(sr.`returns_3year`,2) as returns_3year , round(sr.`returns_5year`,2) as returns_5year , sr.`expenceratio`, sr.`turnover_ratio`, sr.`exitload`, round(sr.`navrs`,2) as navrs , sr.`inception_date`, sr.`minimum_investment`, round(sr.`aumtotal`, 2) as aumtotal , round(sr.`betax_returns`, 2) as betax_returns, round( sr.`alphax_returns`,2) as alphax_returns ,round( sr.`sotinox_returns`,2) as sotinox_returns, round(sr.`sharpex_returns`,2) as sharpex_returns , round( sr.`sdx_returns`,2) as sdx_returns ,sr.fund_manager, sc.`s_name`, rr.`rupeevest_rating`, rr.`portfolio_attributes`, rr.`cost_factor`, rr.`risk`, rr.`consistency_of_return`, rr.`total_return` from scheme_rupeevests sr join scheme_classifications sc on sr.`schemecode`=  sc.`schemecode` join rupeevest_ratings rr on sr.schemecode = rr.schemecode where sc.`classification`= 'Equity : Large Cap'")

		puts "data retrieved"
		puts @schemedata.length
             respond_to do |format|
		     format.json {
				render json: {:schemedata => @schemedata}
			 }
			end
		rescue=> err
			puts err.message
		end
	end

	def get_standard_deviation

		begin

		@standard_dev = ActiveRecord::Base.connection.select_all("SELECT `sd_x` FROM `mf_ratios` WHERE `schemecode`=2")
		#puts @standard_dev


		respond_to do |format|
			 format.json {
				render json: {:standard_dev => @standard_dev}
			 }
		end
		rescue =>err
		  puts err.message
		end
	end

	def get_beta_scheme

		begin
		@beta_schem = ActiveRecord::Base.connection.select_all("SELECT `beta_x` FROM `mf_ratios` WHERE `schemecode` = 2")
		#puts @beta_schem


		respond_to do |format|
			 format.json {
				render json: {:beta_schem => @beta_schem}
			 }
		   end
		rescue =>err
		  puts err.message
		end
	end

	def get_sharp_ratio

		begin

		@sharp_rati = ActiveRecord::Base.connection.select_all("SELECT `sharpe_x` FROM `mf_ratios` WHERE `schemecode` = 2")
		#puts @sharp_rati


		  respond_to do |format|
			 format.json {
				render json: {:sharp_rati => @sharp_rati}
			 }
		end
		rescue =>err
		  puts err.message
		end
	end

	def get_alpha_scheme

		begin

		@alpha_sch = ActiveRecord::Base.connection.select_all("SELECT `jalpha_x` FROM `mf_ratios` WHERE `schemecode` = 2")
		#puts @alpha_sch


		respond_to do |format|
			 format.json {
				render json: {:alpha_sch => @alpha_sch}
			 }
		end
		rescue =>err
		  puts err.message
		end
	end

	def get_sortino_ratio

		begin

		@sortino_rat = ActiveRecord::Base.connection.select_all("SELECT `sortino_x` FROM `mf_ratios` WHERE `schemecode` = 2")
		#puts @sortino_rat


		  respond_to do |format|
			 format.json {
				render json: {:sortino_rat => @sortino_rat}
			 }
		   end
		rescue =>err
		  puts err.message
		end
	end

	def globalvar

		begin
			puts "hi"
			if request.post?
				@selected_scheme_code = params[:schemecode].to_s
				puts "Schemecode : " + selected_scheme_code
				@sortino_rat = ActiveRecord::Base.connection.select_all("SELECT `sortino_x` FROM `mf_ratios` WHERE `schemecode` = 2")
				puts @sortino_rat
				puts Rupeevest::Application::scheme_code

		  respond_to do |format|
			 format.json {
				render json: {:sortino_rat => @sortino_rat}
			 }
		   end
			end
		rescue=> err
			puts err.message
		end
	end

	def asset_class_section

		begin

		if request.post?
				selected_scheme_code = params[:selected_schemes].to_s
				condn_type = params[:condn_type].to_s
				asset_class_condn = ""
				puts "Selected Schemes : " + selected_scheme_code
				puts "Condition type : " + condn_type
				if(condn_type == "factor_score")
					factor_score = selected_scheme_code.split(",")
					asset_class_condn = "rr.total_return = "+factor_score[0]+" or rr.consistency_of_return = "+factor_score[1]+" or rr.risk = "+factor_score[2]+" or rr.cost_factor = "+factor_score[3]+" or rr.portfolio_attributes = "+factor_score[4]
				elsif(condn_type == "filters")
					filters = selected_scheme_code.split(",")
					fund_manager = ""
					index_name = ""
					amc_name = ""

					if (filters[13] == "true")
						index_name = "(sr.index_name in (select index_name from scheme_rupeevests))"
					else
						index_name = "(sr.index_name = '"+filters[10]+"')"
					end

					if (filters[14] == "true")
						index_name = "(sr.index_name in (select index_name from scheme_rupeevests))"
					else
						index_name = "(sr.index_name = '"+filters[11]+"')"
					end

					if (filters[15] == "true")
						fund_manager = "(sr.fund_manager in (select fund_manager from scheme_rupeevests))"
					else
						fund_manager = "(sr.fund_manager = '"+filters[12]+"')"
					end
					asset_class_condn = "(sr.aumtotal > "+filters[0]+" and sr.aumtotal < "+filters[1]+") or (sr.exitload > "+filters[4]+" and sr.exitload < "+filters[5]+") or (sr.turnover_ratio > "+filters[6]+" and sr.turnover_ratio < "+filters[7]+") or (sr.expenceratio > "+filters[8]+" and sr.expenceratio < "+filters[9]+") or "+index_name+" or "+fund_manager+""

				else
					@schemedata_conditions = ActiveRecord::Base.connection.select_all("SELECT * FROM sclass_conditions WHERE cnno in (" + selected_scheme_code + ")")

					@schemedata_conditions.each do |sd|
						if(asset_class_condn == "")
							asset_class_condn = sd['condition_st']
						else
							asset_class_condn = asset_class_condn + " or " + sd['condition_st']
						end
					end
				end


		end
		puts "Asset Class Section : "+asset_class_condn
		@schemedata_sql = "SELECT sr.`schemecode`, round(sr.`returns_1month`, 2) as returns_1month ,round( sr.`returns_3month`, 2) as returns_3month, round( sr.`returns_1year`,2) as returns_1year ,round(sr.`returns_3year`,2) as returns_3year , round(sr.`returns_5year`,2) as returns_5year , sr.`expenceratio`, sr.`turnover_ratio`, sr.`exitload`, round(sr.`navrs`,2) as navrs , sr.`inception_date`, sr.`minimum_investment`, round(sr.`aumtotal`, 2) as aumtotal , round(sr.`betax_returns`, 2) as betax_returns, round( sr.`alphax_returns`,2) as alphax_returns ,round( sr.`sotinox_returns`,2) as sotinox_returns, round(sr.`sharpex_returns`,2) as sharpex_returns , round( sr.`sdx_returns`,2) as assdx_returns ,sr.highest_sector , sc.`s_name`,sr.fund_manager, rr.`rupeevest_rating`, rr.`portfolio_attributes`, rr.`cost_factor`, rr.`risk`, rr.`consistency_of_return`, rr.`total_return`, max( rsh.`hold_perc` ) hold_perc, rs.rv_sect_name highest_sector from scheme_rupeevests sr join scheme_classifications sc on sr.`schemecode`=  sc.`schemecode` join rupeevest_ratings rr on sr.schemecode = rr.schemecode left join `rupeevest_sect_holdpercs` rsh on sr.schemecode = rsh.schemecode left JOIN rupeevest_sectors rs ON rsh.rv_sect_code = rs.rv_sect_code where "+asset_class_condn +" group by sr.schemecode"
		puts @schemedata_sql.to_s
		@schemedata = ActiveRecord::Base.connection.select_all(@schemedata_sql.to_s)


		ten_yrs = ""
		ten_months = ""
		ten_quarters = ""
		for i in 1..10
		   current_year = Date.today.year - i
		   if i==1
				ten_yrs = current_year.to_s
			else
				ten_yrs = ten_yrs.to_s + "," + current_year.to_s
			end
		   puts current_year.to_s
		end
		puts ten_yrs.to_s

		10.downto(1) do |i|
		   current_month = i.months.ago.strftime("%b %y")
		   if i==10
				ten_months = current_month.to_s
			else
				ten_months = ten_months.to_s + "," + current_month.to_s
			end
		   puts current_month.to_s
		end
		puts ten_months
		for i in 1..10
			date = Date.today << (i * 3)
			#[(date.beginning_of_quarter).strftime("%b %y"), (date.end_of_quarter).strftime("%b %y")]
			quarter_year = (date.end_of_quarter).strftime("%b %y")
			if i==1
				ten_quarters = quarter_year.to_s
			else
				ten_quarters = ten_quarters.to_s + "," + quarter_year.to_s
			end
		   puts quarter_year.to_s
		end
		puts ten_quarters

		@landing_returns_sql = "SELECT case when sc.s_name is null then 0 else sc.s_name end s_name,case when sc.classification is null then 0 else sc.classification end classification,case when rr1.`schemecode` is null then 0 else rr1.`schemecode` end `schemecode`, case when rr1.`return_year1` is null then 0 else round( rr1.return_year1 , 2 ) end  return_year1, case when rr1.`return_year2` is null then 0 else round( rr1.return_year2 , 2 ) end `return_year2`,case when rr1.`return_year3` is null then 0 else round( rr1.return_year3 , 2 ) end `return_year3`, case when rr1.`return_year4` is null then 0 else round( rr1.return_year4 , 2 ) end `return_year4`,case when rr1.`return_year5` is null then 0 else round( rr1.return_year5 , 2 ) end `return_year5`,case when rr1.`return_year6` is null then 0 else round( rr1.return_year6 , 2 ) end `return_year6`,case when rr1.`return_year7` is null then 0 else round( rr1.return_year7 , 2 ) end `return_year7`,case when rr1.`return_year8` is null then 0 else round( rr1.return_year8 , 2 ) end `return_year8`,case when rr1.`return_year9` is null then 0 else round( rr1.return_year9 , 2 ) end `return_year9`,case when rr1.`return_year10` is null then 0 else round( rr1.return_year10 , 2 ) end `return_year10`, case when rr1.`return_month1` is null then 0 else round( rr1.return_month1 , 2 ) end `return_month1`, case when rr1.`return_month2` is null then 0 else round( rr1.return_month2 , 2 ) end `return_month2`, case when rr1.`return_month3` is null then 0 else round( rr1.return_month3 , 2 ) end `return_month3`,case when rr1.`return_month4` is null then 0 else round( rr1.return_month4 , 2 ) end `return_month4`, case when rr1.`return_month5` is null then 0 else round( rr1.return_month5 , 2 ) end `return_month5`, case when rr1.`return_month6` is null then 0 else round( rr1.return_month6 , 2 ) end `return_month6`, case when rr1.`return_month7` is null then 0 else round( rr1.return_month7 , 2 ) end `return_month7`, case when rr1.`return_month8` is null then 0 else round( rr1.return_month8 , 2 ) end `return_month8`, case when rr1.`return_month9` is null then 0 else round( rr1.return_month9 , 2 ) end `return_month9`, case when rr1.`return_month10` is null then 0 else round( rr1.return_month10 , 2 ) end `return_month10`,case when rr1.`return_quarter1` is null then 0 else round( rr1.return_quarter1 , 2 ) end `return_quarter1`,case when rr1.`return_quarter2` is null then 0 else round( rr1.return_quarter2 , 2 ) end `return_quarter2`,case when rr1.`return_quarter3` is null then 0 else round( rr1.return_quarter3 , 2 ) end `return_quarter3`, case when rr1.`return_quarter4` is null then 0 else round( rr1.return_quarter4 , 2 ) end `return_quarter4`, case when rr1.`return_quarter5` is null then 0 else round( rr1.return_quarter5 , 2 ) end `return_quarter5`, case when rr1.`return_quarter6` is null then 0 else round( rr1.return_quarter6 , 2 ) end `return_quarter6`,case when rr1.`return_quarter7` is null then 0 else round( rr1.return_quarter7 , 2 ) end `return_quarter7`, case when rr1.`return_quarter8` is null then 0 else round( rr1.return_quarter8 , 2 ) end `return_quarter8`, case when rr1.`return_quarter9` is null then 0 else round( rr1.return_quarter9 , 2 ) end `return_quarter9`, case when rr1.`return_quarter10` is null then 0 else round( rr1.return_quarter10 , 2 ) end `return_quarter10`   FROM scheme_classifications sc join rupeevest_returns rr1  on sc.schemecode = rr1.schemecode join classification_masters cm on sc.classification= cm.classification join `rupeevest_returns_catavgs` ca on  cm.`classification_id`= ca.`classification_id` join scheme_rupeevests sr on sc.schemecode = sr.schemecode join rupeevest_ratings rr on sc.schemecode = rr.schemecode  where "+asset_class_condn + " group by sc.schemecode"

		#@landing_returns_sql="SELECT case when sc.s_name is null then 0 else sc.s_name end s_name,case when sc.classification is null then 0 else sc.classification end classification,case when rr.`schemecode` is null then 0 else rr.`schemecode` end `schemecode`, case when rr.`return_year1` is null then 0 else round( rr.return_year1 , 2 ) end  return_year1, case when rr.`return_year2` is null then 0 else round( rr.return_year2 , 2 ) end `return_year2`,case when rr.`return_year3` is null then 0 else round( rr.return_year3 , 2 ) end `return_year3`, case when rr.`return_year4` is null then 0 else round( rr.return_year4 , 2 ) end `return_year4`,case when rr.`return_year5` is null then 0 else round( rr.return_year5 , 2 ) end `return_year5`,case when rr.`return_year6` is null then 0 else round( rr.return_year6 , 2 ) end `return_year6`,case when rr.`return_year7` is null then 0 else round( rr.return_year7 , 2 ) end `return_year7`,case when rr.`return_year8` is null then 0 else round( rr.return_year8 , 2 ) end `return_year8`,case when rr.`return_year9` is null then 0 else round( rr.return_year9 , 2 ) end `return_year9`,case when rr.`return_year10` is null then 0 else round( rr.return_year10 , 2 ) end `return_year10`, case when rr.`return_month1` is null then 0 else round( rr.return_month1 , 2 ) end `return_month1`, case when rr.`return_month2` is null then 0 else round( rr.return_month2 , 2 ) end `return_month2`, case when rr.`return_month3` is null then 0 else round( rr.return_month3 , 2 ) end `return_month3`,case when rr.`return_month4` is null then 0 else round( rr.return_month4 , 2 ) end `return_month4`, case when rr.`return_month5` is null then 0 else round( rr.return_month5 , 2 ) end `return_month5`, case when rr.`return_month6` is null then 0 else round( rr.return_month6 , 2 ) end `return_month6`, case when rr.`return_month7` is null then 0 else round( rr.return_month7 , 2 ) end `return_month7`, case when rr.`return_month8` is null then 0 else round( rr.return_month8 , 2 ) end `return_month8`, case when rr.`return_month9` is null then 0 else round( rr.return_month9 , 2 ) end `return_month9`, case when rr.`return_month10` is null then 0 else round( rr.return_month10 , 2 ) end `return_month10`,case when rr.`return_quarter1` is null then 0 else round( rr.return_quarter1 , 2 ) end `return_quarter1`,case when rr.`return_quarter2` is null then 0 else round( rr.return_quarter2 , 2 ) end `return_quarter2`,case when rr.`return_quarter3` is null then 0 else round( rr.return_quarter3 , 2 ) end `return_quarter3`, case when rr.`return_quarter4` is null then 0 else round( rr.return_quarter4 , 2 ) end `return_quarter4`, case when rr.`return_quarter5` is null then 0 else round( rr.return_quarter5 , 2 ) end `return_quarter5`, case when rr.`return_quarter6` is null then 0 else round( rr.return_quarter6 , 2 ) end `return_quarter6`,case when rr.`return_quarter7` is null then 0 else round( rr.return_quarter7 , 2 ) end `return_quarter7`, case when rr.`return_quarter8` is null then 0 else round( rr.return_quarter8 , 2 ) end `return_quarter8`, case when rr.`return_quarter9` is null then 0 else round( rr.return_quarter9 , 2 ) end `return_quarter9`, case when rr.`return_quarter10` is null then 0 else round( rr.return_quarter10 , 2 ) end `return_quarter10`   FROM scheme_classifications sc join rupeevest_returns rr  on sc.schemecode = rr.schemecode join classification_masters cm on sc.classification= cm.classification join `rupeevest_returns_catavgs` ca on  cm.`classification_id`= ca.`classification_id`  where "+asset_class_condn + " group by sc.schemecode"
		puts @sql.to_s
		@return_tab = ActiveRecord::Base.connection.select_all( @landing_returns_sql.to_s)

		  respond_to do |format|
			 format.json {
				render json: {:schemedata => @schemedata,:return_tab => @return_tab,:ten_yrs=>ten_yrs,:ten_months=>ten_months,:ten_quarters=>ten_quarters}
			 }
			end

		rescue=> err
			puts err.message
		end
	end

def get_dividend_data

	begin
		selected_scheme_code = session[:schemecode].to_s

		if(selected_scheme_code == "")

			respond_to do |format|
				format.json {
				render json:{:schemedata=>selected_scheme_code}
			}
			end
		else
			puts "Schemecode Received for Query: " + selected_scheme_code.to_s
			@dividend_data = ActiveRecord::Base.connection.select_all("SELECT sd.schemecode,date_format( dd.`recorddate`, '%Y-%m-%d' ) `recorddate`,round(dd.gross,2) as gross, dm.div_type FROM`scheme_details_fulls` sd join divdetails dd on sd.schemecode = dd.schemecode join div_msts dm on dd.div_code = dm.div_code WHERE sd.`primary_fd_code` = (select * from(SELECT primary_fd_code FROM `scheme_details_fulls` WHERE schemecode = " + selected_scheme_code + ") as temp ) and sd.opt_code =2 and sd.plan in (6,2) order by dd.recorddate desc limit 7")
			respond_to do |format|
				format.json {
				render json: {:dividend_data => @dividend_data}
			}
			end
	end
	rescue=> err
		puts err.message
	end
end

	def get_peer_comparision()

		begin
			#selected_scheme_code = params[:schemecode].to_s
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end

			else
				puts "Schemecode Received for Query: " + selected_scheme_code.to_s
				@sql="select sc1.`s_name`,rr1.`rupeevest_rating`, sr1.rank_3year, round(sr1.`ytd_returns`, 2) as `ytd_returns`,round(sr1.`returns_1month`,2) as `returns_1month` , round(sr1.`returns_3month`,2) as `returns_3month`, round(sr1.`returns_1year`, 2) as `returns_1year`, round(sr1.`returns_3year`,2) as `returns_3year`, round(sr1.`returns_5year`,2) as `returns_5year`, round(sr1.`aumtotal`,2) as `aumtotal`, round(sr1.`expenceratio`,2) as `expenceratio`,sr1.schemecode from scheme_rupeevests sr1 join scheme_classifications sc1 on sr1.schemecode = sc1.schemecode join rupeevest_ratings rr1 on sr1.schemecode = rr1.schemecode   where sr1.rank_3year > 0 and sc1.classification = (SELECT sc.classification FROM `scheme_rupeevests` sr join scheme_classifications sc on sr.schemecode = sc.schemecode WHERE sr.`schemecode` = " + selected_scheme_code + " ) and sr1.schemecode != " + selected_scheme_code + " order by sr1.rank_3year asc limit 4"
				puts @sql.to_s
				@peer_comparision = ActiveRecord::Base.connection.select_all(@sql.to_s)
				puts @schemedata.to_s
				# @schemedata = ActiveRecord::Base.connection.select_all("SELECT sd.schemecode,sd.`s_name`,sd.fund_mgr1,sd.fund_mgr2,sd.fund_mgr3,sd.fund_mgr4, sd.lockperiod, max(sc.exitload) as exitload, max(ex.exratio) as exratio, max(sa.`mininv`) as mininv, date_format(mr.`incdate`,'%Y-%m-%d') as incdate,  round( max( bm.`incret`) , 2 ) AS incret, max(ag.`turnover_ratio`) as turnover_ratio,date_format(cn.`navdate`,'%Y-%m-%d') as navdate , cn.`navrs` , cn.`change` AS navchange,tm.type, scf.classification,sm.total,max(sm.date) as aumdate FROM scheme_details_fulls sd join schemeloads sc on sd.schemecode =sc.schemecode  join expenceratios ex on sd.schemecode = ex.schemecode join scheme_assetallocs sa on sd.schemecode = sa.schemecode join mf_abs_returns mr on sd.schemecode = mr.schemecode join bm_indices_res bm on sd.schemecode = bm.index_code join avg_maturities ag on sd.schemecode = ag.schemecode join currentnavs cn on sd.schemecode = cn.schemecode JOIN type_msts tm ON sd.type_code = tm.type_code JOIN scheme_classifications scf ON sd.schemecode = scf.schemecode join scheme_aums sm on sd.schemecode = sm.schemecode where  sc.schemecode = " + selected_scheme_code)

				respond_to do |format|
					format.json {
					render json: {:peer_comparision=>@peer_comparision}
				}
				end


			end

		rescue=> err
			puts err.message
		end
	end

	def get_return_data()
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
				puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		@returns_data = ActiveRecord::Base.connection.select_all("SELECT sr.`schemecode`, sr.`fund_house`, round(sr.`returns_1month`, 2) as`returns_1month`, round(sr.`returns_3month`, 2) as `returns_3month`, round(sr.`returns_1year`, 2) as `returns_1year`, sr.`index_name`, round(sr.`returns_3year`, 2) as `returns_3year`, round(sr.`returns_5year`, 2) as `returns_5year`, round(sr.`ytd_returns`, 2) as `ytd_returns`, sr.`rank_ytd`,sr.`rank_1month`,sr.`rank_3month`, sr.`rank_1year`, sr.`rank_3year`, sr.`rank_5year`, sc.`s_name`,sc.classification, rc.`no_of_funds_total`, round(rc.`ytd_avg`,2) as `ytd_avg` , round(rc.`avg_month1`,2) as `avg_month1` , round( rc.`avg_month3`,2) as `avg_month3` , round(rc.`avg_year1`,2) as `avg_year1` , round(rc.`avg_year3`,2) as `avg_year3` , round(rc.`avg_year5`,2) as `avg_year5`,round(br.monthret_1,2) as monthret_1,round(br.`monthret_3`,2) as `monthret_3`, round(`yrret_1`,2) as `yrret_1`, round(`yrret_3`,2) as `yrret_3`, round(`yrret_5`, 2) as `yrret_5`, round(`ytdret`,2) as `ytdret`  from scheme_rupeevests sr join scheme_classifications sc on sr.`schemecode`= sc.`schemecode` join classification_masters cm on sc.classification = cm.classification join rupeevest_categories rc on cm.classification_id = rc.classification_id join bm_indices_res br on sr.index_code = br.index_code where sr.schemecode = " + selected_scheme_code)


		  respond_to do |format|
			 format.json {
				render json: {:returns_data => @returns_data}
			 }
			end
		end

		rescue=> err
			puts err.message
		end
end


	def get_risk_measures()

		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
				puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		      @risk_data = ActiveRecord::Base.connection.select_all("SELECT sr.`schemecode`, max(round(sr.`sdx_returns`,2)) as `sdx_returns`, max(round(sr.`sharpex_returns`,2)) as `sharpex_returns`, max(round(sr.`sotinox_returns`,2)) as `sotinox_returns`, max(round(sr.`betax_returns`,2)) as `betax_returns`, max(round(sr.`alphax_returns`, 2)) as `alphax_returns`, max(round(sr.`treynorx_returns`,2)) as`treynorx_returns` , max(round(sr.`sdy_returns`,2)) as `sdy_returns`, max(round(sr.`sharpey_returns`,2)) as `sharpey_returns`, max(round(sr.`sotinoy_returns`,2)) as `sotinoy_returns`, max(round(sr.`betay_returns`,2)) as `betay_returns`, max(round(sr.`alphay_returns`,2)) as `alphay_returns`, max(round(sr.`treynory_returns`,2)) as `treynory_returns`, sr.`rank_sd`, sr.`rank_sharpe`, sr.`rank_sotino`, sr.`rank_beta`, sr.`rank_alpha`, sr.`rank_treynor`, sr.`index_name`,sc.`s_name`, round(rc.`avg_std_dev`,2) as `avg_std_dev` , round(`avg_sharpe`,2) as `avg_sharpe`, round(`avg_sotino`,2) as `avg_sotino`, round(`avg_beta`,2) as `avg_beta`,round(`avg_alpha`,2) as `avg_alpha`, round(`avg_treyno`,2) as `avg_treyno`, rc.`no_of_funds_total`   FROM `scheme_rupeevests` sr join `scheme_classifications` sc on sr.`schemecode` join classification_masters cm on sc.classification = cm.classification join rupeevest_categories rc on cm.classification_id = rc.classification_id where sr.schemecode = " + selected_scheme_code)


		    respond_to do |format|
			 format.json {
				render json: {:risk_data => @risk_data}
			 }
			end
		end

		rescue=> err
			puts err.message
		end
end


	# def portfolio_holdings

		# begin
			# @portfolio_holdings = ActiveRecord::Base.connection.select_all ("SELECT schemecode, sect_name, asect_name, rating, holdpercentage AS weight FROM mf_portfolios LIMIT 3 " )

			# respond_to do |format|
			     # format.json {
				   # render json: {:portfolio_holdings => @portfolio_holdings}
			       # }
				# end
		# rescue =>err
			# puts err.message
		# end
    # end

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

	def get_protfolio_avgmarketcap

	begin
       @market = ActiveRecord::Base.connection.select_all("SELECT schemecode, portfolio_marketcap, fund, category_avg FROM portfolio_marketcaps ")
            puts @market

		        respond_to do |format|
			    format.json {
				  render json: {:market => @market}
			      }
		       end
		        rescue =>err
		        puts err.message
	  end
    end


   def get_nav_graph

		begin

		 @nav_graph = ActiveRecord::Base.connection.select_all("SELECT `navdate` , `navrs` FROM `navhistfulls` WHERE `schemecode` =15 AND Date_format( `navdate` , '%Y-%m-%d' ) > Date_format( '2015-06-01', '%Y-%m-%d' ) ORDER BY navdate DESC")
		  respond_to do |format|
			 format.json {
				render json: {:nav_graph => @nav_graph}
			 }
		   end
		rescue =>err
			puts err.message
		end
	end

	def get_concentration_value

		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end

			else
				@pe_pb = ActiveRecord::Base.connection.select_all("SELECT round(`pe`,2) as pe ,round (`pb`,2) as pb,max(`monthend`)as monthend FROM `pe_pb_ratios` WHERE `schemecode`= "+selected_scheme_code.to_s)

				@stock_data = ActiveRecord::Base.connection.select_all("SELECT `invdate` , round(`holdpercentage`,2) as holdpercentage , `compname` FROM `mf_portfolios` WHERE `schemecode` ="+selected_scheme_code.to_s+" AND asect_code =1 AND DATE_FORMAT( `invdate` , '%Y-%m-%d' ) =  date_format((select max(date_format(invdate,'%Y-%m-%d')) as invdate from sect_allocations),'%Y-%m-%d') ORDER BY `holdpercentage` DESC")

				@pe_pb.each do |pp|
					@pe = pp['pe']
					@pb = pp['pb']
				end

				@count = @stock_data.length

				@top3_sum = 0
				@top5_sum = 0
				@top10_sum = 0
				@i = 1
				@stock_data.each do |sd|
					if @i < 4
						@top3_sum = @top3_sum + sd['holdpercentage']
					end

					if @i < 6
						@top5_sum = @top5_sum + sd['holdpercentage']
					end

					if @i < 11
						@top10_sum = @top10_sum + sd['holdpercentage']
					end
					@i = @i+1
				end
				puts @pe.to_s
				puts @pb.to_s
				puts @top3_sum.to_s
				puts @top5_sum.to_s
				puts @top10_sum.to_s
				@concen_value = Array[@count.to_s,@pe.to_s,@pb.to_s,@top3_sum.to_s,@top5_sum.to_s,@top10_sum.to_s]
				puts @concen_value
					respond_to do |format|
					format.json {
					render json: {:concen_value => @concen_value}
					}
				end
			end
		rescue =>err
			puts err.message
		end
	end

  def get_recent_updates

    begin

     @Recent_updates = ActiveRecord::Base.connection.select_all("SELECT `headline`,`date` FROM `mfi_news` ORDER by `date` limit 4")
     puts @Recent_updates
        respond_to do |format|
         format.json {
            render json: {:Recent_updates => @Recent_updates}
         }
         end
    rescue =>err
        puts err.message
    end
end

	def get_peer_comparision()

		begin
			#selected_scheme_code = params[:schemecode].to_s
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end

			else
				puts "Schemecode Received for Query: " + selected_scheme_code.to_s
				@sql="select sc1.`s_name`,rr1.`rupeevest_rating`, sr1.rank_3year, round(sr1.`ytd_returns`, 2) as `ytd_returns`,round(sr1.`returns_1month`,2) as `returns_1month` , round(sr1.`returns_3month`,2) as `returns_3month`, round(sr1.`returns_1year`, 2) as `returns_1year`, round(sr1.`returns_3year`,2) as `returns_3year`, round(sr1.`returns_5year`,2) as `returns_5year`, round(sr1.`aumtotal`,2) as `aumtotal`, round(sr1.`expenceratio`,2) as `expenceratio`,sr1.schemecode from scheme_rupeevests sr1 join scheme_classifications sc1 on sr1.schemecode = sc1.schemecode join rupeevest_ratings rr1 on sr1.schemecode = rr1.schemecode   where sr1.rank_3year > 0 and sc1.classification = (SELECT sc.classification FROM `scheme_rupeevests` sr join scheme_classifications sc on sr.schemecode = sc.schemecode WHERE sr.`schemecode` = " + selected_scheme_code + " ) and sr1.schemecode != " + selected_scheme_code + " order by sr1.rank_3year asc limit 4"
				puts @sql.to_s
				@peer_comparision = ActiveRecord::Base.connection.select_all(@sql.to_s)
				puts @schemedata.to_s
				# @schemedata = ActiveRecord::Base.connection.select_all("SELECT sd.schemecode,sd.`s_name`,sd.fund_mgr1,sd.fund_mgr2,sd.fund_mgr3,sd.fund_mgr4, sd.lockperiod, max(sc.exitload) as exitload, max(ex.exratio) as exratio, max(sa.`mininv`) as mininv, date_format(mr.`incdate`,'%Y-%m-%d') as incdate,  round( max( bm.`incret`) , 2 ) AS incret, max(ag.`turnover_ratio`) as turnover_ratio,date_format(cn.`navdate`,'%Y-%m-%d') as navdate , cn.`navrs` , cn.`change` AS navchange,tm.type, scf.classification,sm.total,max(sm.date) as aumdate FROM scheme_details_fulls sd join schemeloads sc on sd.schemecode =sc.schemecode  join expenceratios ex on sd.schemecode = ex.schemecode join scheme_assetallocs sa on sd.schemecode = sa.schemecode join mf_abs_returns mr on sd.schemecode = mr.schemecode join bm_indices_res bm on sd.schemecode = bm.index_code join avg_maturities ag on sd.schemecode = ag.schemecode join currentnavs cn on sd.schemecode = cn.schemecode JOIN type_msts tm ON sd.type_code = tm.type_code JOIN scheme_classifications scf ON sd.schemecode = scf.schemecode join scheme_aums sm on sd.schemecode = sm.schemecode where  sc.schemecode = " + selected_scheme_code)
				respond_to do |format|
					format.json {
					render json: {:peer_comparision=>@peer_comparision}
				}
				end

			end

		rescue=> err
			puts err.message
		end
	end

	def asect_allocation_chart
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else

				# @sql = "SELECT `schemecode` , `invdate` , `asect_code` , sum( `holdpercentage` ) FROM `mf_portfolios` WHERE `schemecode` =15 AND Date_format( invdate, '%Y-%m-%d' ) = Date_format( '2016-03-31', '%Y-%m-%d' ) GROUP BY `asect_code`"

				@sql = "SELECT round( sum( mf.`holdpercentage` ) , 2 )as holdpercentage,am.`rupeevest_asect` FROM `mf_portfolios` mf join asect_mst_news am on mf.`asect_code` = am.`asect_code` WHERE mf.`schemecode` = "+selected_scheme_code.to_s+" AND DATE_FORMAT( mf.`invdate` , '%Y-%m-%d' ) = date_format((select max(date_format(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') GROUP BY am.`rupeevest_asect`"

				puts @sql.to_s

				@asect_alloc_chart = ActiveRecord::Base.connection.select_all(@sql.to_s)
				respond_to do |format|
					format.json {
					render json:{:asect_alloc_chart=>@asect_alloc_chart}
				}
				end
			end
		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def portfolio_holdings()

		begin
		selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
			@portfolio_holdings = ActiveRecord::Base.connection.select_all ("SELECT `compname` , `sect_name` , `rating` ,round(`holdpercentage`, 2) as `holdpercentage` FROM `mf_portfolios` WHERE `schemecode` = "+selected_scheme_code+" AND date_format( `invdate` , '%Y-%m-%d' ) = date_format((select max(date_format(invdate,'%Y-%m-%d')) as invdate from sect_allocations),'%Y-%m-%d') ORDER BY `mf_portfolios`.`holdpercentage` DESC" )

			respond_to do |format|
			    format.json {
				  render json: {:portfolio_holdings => @portfolio_holdings}
			      }
				end
			end
		rescue =>err
			puts err.message
		end
    end

	def get_returns_year
  	begin
  	selected_scheme_code = session[:schemecode].to_s

		if(selected_scheme_code == "")

			respond_to do |format|
				format.json {
				render json:{:schemedata=>selected_scheme_code}
			}
			end
		else
			puts "Schemecode Received for Query: " + selected_scheme_code.to_s

		   @returns_year = ActiveRecord::Base.connection.select_all("SELECT case when sc.s_name is null then 0 else sc.s_name end s_name,case when sc.classification is null then 0 else sc.classification end classification,case when rr.`schemecode` is null then 0 else rr.`schemecode` end `schemecode`, case when rr.`return_year1` is null then 0 else round( rr.return_year1 , 2 ) end  return_year1, case when rr.`return_year2` is null then 0 else round( rr.return_year2 , 2 ) end `return_year2`, case when rr.`return_year3` is null then 0 else round( rr.return_year3 , 2 ) end `return_year3`, case when rr.`return_year4` is null then 0 else round( rr.return_year4 , 2 ) end `return_year4`, case when rr.`return_year5` is null then 0 else round( rr.return_year5 , 2 ) end `return_year5`, case when rr.`return_year6` is null then 0 else round( rr.return_year6 , 2 ) end `return_year6`, case when rr.`return_year7` is null then 0 else round( rr.return_year7 , 2 ) end `return_year7`, case when rr.`return_year8` is null then 0 else round( rr.return_year8 , 2 ) end `return_year8`, case when rr.`return_year9` is null then 0 else round( rr.return_year9 , 2 ) end `return_year9`, case when rr.`return_year10` is null then 0 else round( rr.return_year10 , 2 ) end `return_year10`, case when rr.`rank_year1` is null then 0 else round( rr.rank_year1 , 2 ) end `rank_year1`, case when rr.`rank_year2` is null then 0 else round( rr.rank_year2 , 2 ) end `rank_year2`, case when rr.`rank_year3` is null then 0 else round( rr.rank_year3 , 2 ) end `rank_year3`, case when rr.`rank_year4` is null then 0 else round( rr.rank_year4 , 2 ) end `rank_year4`, case when rr.`rank_year5` is null then 0 else round( rr.rank_year5 , 2 ) end `rank_year5`, case when rr.`rank_year6` is null then 0 else round( rr.rank_year6 , 2 ) end `rank_year6`, case when rr.`rank_year7` is null then 0 else round( rr.rank_year7 , 2 ) end `rank_year7`, case when rr.`rank_year8` is null then 0 else round( rr.rank_year8 , 2 ) end `rank_year8`, case when rr.`rank_year9` is null then 0 else round( rr.rank_year9 , 2 ) end `rank_year9`, case when rr.`rank_year10` is null then 0 else round( rr.rank_year10 , 2 ) end `rank_year10`, case when rr.`return_month1` is null then 0 else round( rr.return_month1 , 2 ) end `return_month1`, case when rr.`return_month2` is null then 0 else round( rr.return_month2 , 2 ) end `return_month2`, case when rr.`return_month3` is null then 0 else round( rr.return_month3 , 2 ) end `return_month3`, case when rr.`return_month4` is null then 0 else round( rr.return_month4 , 2 ) end `return_month4`, case when rr.`return_month5` is null then 0 else round( rr.return_month5 , 2 ) end `return_month5`, case when rr.`return_month6` is null then 0 else round( rr.return_month6 , 2 ) end `return_month6`, case when rr.`return_month7` is null then 0 else round( rr.return_month7 , 2 ) end `return_month7`, case when rr.`return_month8` is null then 0 else round( rr.return_month8 , 2 ) end `return_month8`, case when rr.`return_month9` is null then 0 else round( rr.return_month9 , 2 ) end `return_month9`, case when rr.`return_month10` is null then 0 else round( rr.return_month10 , 2 ) end `return_month10`, case when rr.`rank_month1` is null then 0 else rr.`rank_month1` end `rank_month1`, case when rr.`rank_month2` is null then 0 else rr.`rank_month2` end `rank_month2`, case when rr.`rank_month3` is null then 0 else rr.`rank_month3` end `rank_month3`, case when rr.`rank_month4` is null then 0 else rr.`rank_month4` end `rank_month4`, case when rr.`rank_month5` is null then 0 else rr.`rank_month5` end `rank_month5`, case when rr.`rank_month6` is null then 0 else rr.`rank_month6` end `rank_month6`, case when rr.`rank_month7` is null then 0 else rr.`rank_month7` end `rank_month7`, case when rr.`rank_month8` is null then 0 else rr.`rank_month8` end `rank_month8`, case when rr.`rank_month9` is null then 0 else rr.`rank_month9` end `rank_month9`, case when rr.`rank_month10` is null then 0 else rr.`rank_month10` end `rank_month10`, case when rr.`return_quarter1` is null then 0 else round( rr.return_quarter1 , 2 ) end `return_quarter1`, case when rr.`return_quarter2` is null then 0 else round( rr.return_quarter2 , 2 ) end `return_quarter2`, case when rr.`return_quarter3` is null then 0 else round( rr.return_quarter3 , 2 ) end `return_quarter3`, case when rr.`return_quarter4` is null then 0 else round( rr.return_quarter4 , 2 ) end `return_quarter4`, case when rr.`return_quarter5` is null then 0 else round( rr.return_quarter5 , 2 ) end `return_quarter5`, case when rr.`return_quarter6` is null then 0 else round( rr.return_quarter6 , 2 ) end `return_quarter6`,case when rr.`return_quarter7` is null then 0 else round( rr.return_quarter7 , 2 ) end `return_quarter7`, case when rr.`return_quarter8` is null then 0 else round( rr.return_quarter8 , 2 ) end `return_quarter8`, case when rr.`return_quarter9` is null then 0 else round( rr.return_quarter9 , 2 ) end `return_quarter9`, case when rr.`return_quarter10` is null then 0 else round( rr.return_quarter10 , 2 ) end `return_quarter10`, case when rr.`rank_quarter1` is null then 0 else rr.`rank_quarter1` end `rank_quarter1`, case when rr.`rank_quarter2` is null then 0 else rr.`rank_quarter2` end `rank_quarter2`, case when rr.`rank_quarter3` is null then 0 else rr.`rank_quarter3` end `rank_quarter3`, case when rr.`rank_quarter4` is null then 0 else rr.`rank_quarter4` end `rank_quarter4`, case when rr.`rank_quarter5` is null then 0 else rr.`rank_quarter5` end `rank_quarter5`, case when rr.`rank_quarter6` is null then 0 else rr.`rank_quarter6` end `rank_quarter6`,  case when rr.`rank_quarter7` is null then 0 else rr.`rank_quarter7` end `rank_quarter7`,  case when rr.`rank_quarter8` is null then 0 else rr.`rank_quarter8` end `rank_quarter8`,  case when rr.`rank_quarter9` is null then 0 else rr.`rank_quarter9` end `rank_quarter9`,  case when rr.`rank_quarter10` is null then 0 else rr.`rank_quarter10` end `rank_quarter10`,  case when ca.`avg_year1` is null then 0 else round( ca.avg_year1 , 2 ) end `avg_year1`,  case when ca.`avg_year2` is null then 0 else round( ca.avg_year2 , 2 ) end `avg_year2`,  case when ca.`avg_year3` is null then 0 else round( ca.avg_year3 , 2 ) end `avg_year3`,  case when ca.`avg_year4` is null then 0 else round( ca.avg_year4 , 2 ) end `avg_year4`,  case when ca.`avg_year5` is null then 0 else round( ca.avg_year5 , 2 ) end `avg_year5`,  case when ca.`avg_year6` is null then 0 else round( ca.avg_year6 , 2 ) end `avg_year6`,  case when ca.`avg_year7` is null then 0 else round( ca.avg_year7 , 2 ) end `avg_year7`,  case when ca.`avg_year8` is null then 0 else round( ca.avg_year8 , 2 ) end `avg_year8`,  case when ca.`avg_year9` is null then 0 else round( ca.avg_year9 , 2 ) end `avg_year9`,  case when ca.`avg_year10` is null then 0 else round( ca.avg_year10 , 2 ) end `avg_year10`,  case when ca.`avg_month1` is null then 0 else round( ca.avg_month1 , 2 ) end `avg_month1`,  case when ca.`avg_month2` is null then 0 else round( ca.avg_month2 , 2 ) end `avg_month2`,  case when ca.`avg_month3` is null then 0 else round( ca.avg_month3 , 2 ) end `avg_month3`,  case when ca.`avg_month4` is null then 0 else round( ca.avg_month4 , 2 ) end `avg_month4`,  case when ca.`avg_month5` is null then 0 else round( ca.avg_month5 , 2 ) end `avg_month5`,  case when ca.`avg_month6` is null then 0 else round( ca.avg_month6 , 2 ) end `avg_month6`,  case when ca.`avg_month7` is null then 0 else round( ca.avg_month7 , 2 ) end `avg_month7`,  case when ca.`avg_month8` is null then 0 else round( ca.avg_month8 , 2 ) end `avg_month8`,  case when ca.`avg_month9` is null then 0 else round( ca.avg_month9 , 2 ) end `avg_month9`,  case when ca.`avg_month10` is null then 0 else round( ca.avg_month10 , 2 ) end `avg_month10`,  case when ca.`avg_quarter1` is null then 0 else round( ca.avg_quarter1 , 2 ) end `avg_quarter1`,  case when ca.`avg_quarter2` is null then 0 else round( ca.avg_quarter2 , 2 ) end `avg_quarter2`,  case when ca.`avg_quarter3` is null then 0 else round( ca.avg_quarter3 , 2 ) end `avg_quarter3`,  case when ca.`avg_quarter4` is null then 0 else round( ca.avg_quarter4 , 2 ) end `avg_quarter4`,  case when ca.`avg_quarter5` is null then 0 else round( ca.avg_quarter5 , 2 ) end `avg_quarter5`,  case when ca.`avg_quarter6` is null then 0 else round( ca.avg_quarter6 , 2 ) end `avg_quarter6`,  case when ca.`avg_quarter7` is null then 0 else round( ca.avg_quarter7 , 2 ) end `avg_quarter7`,  case when ca.`avg_quarter8` is null then 0 else round( ca.avg_quarter8 , 2 ) end `avg_quarter8`,  case when ca.`avg_quarter9` is null then 0 else round( ca.avg_quarter9 , 2 ) end `avg_quarter9`,  case when ca.`avg_quarter10` is null then 0 else round( ca.avg_quarter10 , 2 )end `avg_quarter10`  FROM scheme_classifications sc join rupeevest_returns rr  on sc.schemecode = rr.schemecode join classification_masters cm on sc.classification= cm.classification join `rupeevest_returns_catavgs` ca on  cm.`classification_id`= ca.`classification_id`  where sc.`schemecode`="  + selected_scheme_code)

			 # @returns_year = ActiveRecord::Base.connection.select_all("SELECT  sc.s_name ,  sc.classification ,  rr.`schemecode`, rr.`return_year1`,rr.`return_year2`, rr.`return_year3`, rr.`return_year4`, rr.`return_year5`,rr.`return_year6`, rr.`return_year7` ,rr.`return_year8`,rr.`return_year9`,rr.`return_year10`,rr.`rank_year1`,rr.`rank_year2`,rr.`rank_year3`,rr.`rank_year4`,rr.`rank_year5`,rr.`rank_year6`,rr.`rank_year7`,rr.`rank_year8`,rr.`rank_year9`,rr.`rank_year10`, rr.`return_month1`, rr.`return_month2`, rr.`return_month3`, rr.`return_month4`, rr.`return_month5`, rr.`return_month6`, rr.`return_month7`, rr.`return_month8`, rr.`return_month9`, rr.`return_month10`, rr.`rank_month1`, rr.`rank_month2`, rr.`rank_month3`, rr.`rank_month4`, rr.`rank_month5`, rr.`rank_month6`, rr.`rank_month7`, rr.`rank_month8`, rr.`rank_month9`, rr.`rank_month10`, rr.`return_quarter1`, rr.`return_quarter2`, rr.`return_quarter3`, rr.`return_quarter4`, rr.`return_quarter5`, rr.`return_quarter6`, rr.`return_quarter7`, rr.`return_quarter8`, rr.`return_quarter9`, rr.`return_quarter10`, rr.`rank_quarter1`, rr.`rank_quarter2`, rr.`rank_quarter3`, rr.`rank_quarter4`, rr.`rank_quarter5`,rr.`rank_quarter6`,rr.`rank_quarter7`, rr.`rank_quarter8`, rr.`rank_quarter9`, rr.`rank_quarter10`, ca.`avg_year1`,ca.`avg_year2`,ca.`avg_year3`,ca.`avg_year4`,ca.`avg_year5`,ca.`avg_year6`, ca.`avg_year7` `,ca.`avg_year8`,ca.`avg_year9`,ca.`avg_year10`, ca.`avg_month1`, ca.`avg_month2`, ca.`avg_month3`, ca.`avg_month4`, ca.`avg_month5`, ca.`avg_month6`, ca.`avg_month7`, ca.`avg_month8`, ca.`avg_month9`, ca.`avg_month10`, ca.`avg_quarter1`, ca.`avg_quarter2`, ca.`avg_quarter3`, ca.`avg_quarter4`, ca.`avg_quarter5`, ca.`avg_quarter6`, ca.`avg_quarter7`,ca.`avg_quarter8`, ca.`avg_quarter9`, ca.`avg_quarter10` FROM scheme_classifications sc join rupeevest_returns rr  on sc.schemecode = rr.schemecode join classification_masters cm on sc.classification= cm.classification join `rupeevest_returns_catavgs` ca on  cm.`classification_id`= ca.`classification_id`  where sc.`schemecode`=" + selected_scheme_code)

		   puts @returns_year
		   respond_to do |format|
			format.json {
				render json: {:returns_year => @returns_year}
			}
			end
		end
	rescue=> err
		puts err.message
	end
end

def get_protfolio_graph
  	begin
  	selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
				puts "Schemecode Received for Query: " + selected_scheme_code.to_s

				@select_class = "Select * from scheme_classifications where schemecode = "+ selected_scheme_code.to_s
				@select_data = ActiveRecord::Base.connection.select_all(@select_class.to_s)
				classification =""
				@select_data.each do |sd|
					classification = sd['classification']
				end
				type = classification.split(":")
				puts type[0]
				if(type[0].strip == "Equity")
					@port_graph = ActiveRecord::Base.connection.select_all("SELECT rsh.schemecode,round(rsh.hold_perc,2) hold_perc, sc.classification, round(rsc.cat_avg,2) as cat_avg, rs.rv_sect_name FROM `rupeevest_sect_holdpercs` rsh join scheme_classifications sc on rsh.schemecode = sc.schemecode join classification_masters cm on sc.classification = cm.classification join rupeevest_sector_cat_avgs rsc on rsc.classification_id = cm.classification_id and rsh.rv_sect_code = rsc.rv_sect_code join rupeevest_sectors rs on rsc.rv_sect_code = rs.rv_sect_code WHERE rsh.`schemecode` = " + selected_scheme_code + " order by rsh.hold_perc desc limit 10")
				elsif(type[0].strip == "Debt")
					@port_graph = ActiveRecord::Base.connection.select_all("SELECT count(*) cnt,round(sum(holdpercentage),2) as  holdpercentage, round(sum(holdpercentage)/count(*),2) as average,rupeevest_group FROM `credit_rating_sum_groups` WHERE `classification` = '"+classification+"' group by rupeevest_group")
				elsif(type[0].strip == "Hybrid")
					@port_graph_sector = ActiveRecord::Base.connection.select_all("SELECT rsh.schemecode,round(rsh.hold_perc,2) hold_perc, sc.classification, round(rsc.cat_avg,2) as cat_avg, rs.rv_sect_name FROM `rupeevest_sect_holdpercs` rsh join scheme_classifications sc on rsh.schemecode = sc.schemecode join classification_masters cm on sc.classification = cm.classification join rupeevest_sector_cat_avgs rsc on rsc.classification_id = cm.classification_id and rsh.rv_sect_code = rsc.rv_sect_code join rupeevest_sectors rs on rsc.rv_sect_code = rs.rv_sect_code WHERE rsh.`schemecode` = " + selected_scheme_code + " order by rsh.hold_perc desc limit 10")

				 @port_graph_credit = ActiveRecord::Base.connection.select_all("SELECT count(*) cnt,round(sum(holdpercentage),2) as  holdpercentage, round(sum(holdpercentage)/count(*),2) as average,rupeevest_group FROM `credit_rating_sum_groups` WHERE `classification` = '"+classification+"' group by rupeevest_group")
				end



		   puts@port_graph
		   if(type[0].strip == "Hybrid")
				 	puts @port_graph_sector
					puts @port_graph_credit
				respond_to do |format|
					format.json {
					render json: {:port_graph_sector => @port_graph_sector,:port_graph_credit => @port_graph_credit,:classification=> type[0].strip}
				}
				end
			else
				respond_to do |format|
					format.json {
					render json: {:port_graph => @port_graph,:classification=> type[0].strip}
				}
				end
			end
		end
		rescue=> err
			puts err.message
	end
end

	def get_growth_plan
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
			  puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		      @growth_plan = ActiveRecord::Base.connection.select_all("SELECT sd.schemecode,sd.opt_code,sd.plan,sd.div_freq,na.navrs,na.navdate,dm.div_type,op.option,pm.plan   FROM scheme_details_fulls sd join navhistfull_adjnavs na on sd.schemecode = na.schemecode left outer join div_msts dm on sd.div_freq = dm.div_code join options_masts op on sd.opt_code = op.opt_code join plan_msts pm on sd.plan = pm.plan_code WHERE sd.primary_fd_code = "+selected_scheme_code+" and sd.schemecode  not in ("+selected_scheme_code+") and date_format(na.navdate,'%Y-%m-%d') = date_format((select max(date_format(navdate,'%Y-%m-%d')) as navdate from navhistfull_adjnavs),'%Y-%m-%d') and sd.plan <> 7")
		      respond_to do |format|
               format.json {
				render json: {:growth_plan => @growth_plan}
			   }
			end
		end
		rescue=> err
			puts err.message
		end
	end

	def portfolio_markettable
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
			  puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		      @cap_values = ActiveRecord::Base.connection.select_all("select round(sc.lcap_holdpercentage,2) lcap, round(sc.mcap_holdpercentage,2) mcap, round(sc.scap_holdpercentage,2) scap,round(pp.mcap,2) ppmcap  from scheme_classifications sc join pe_pb_ratios pp on sc.schemecode = pp.schemecode where sc.schemecode = "+selected_scheme_code+" order by pp.monthend desc limit 1")
			  puts @cap_values.length
			  @cap_values.each do |cv|
				lcap_holdpercentage = cv['lcap']
				mcap_holdpercentage = cv['mcap']
				scap_holdpercentage = cv['scap']
				ppmcap = cv['ppmcap']
			  end
		      respond_to do |format|
              format.json {
				render json: {:cap_values => @cap_values}
			   }
				end
			end
		rescue=> err
			puts err.message
		end
	end

	def portfolio_markettable_avgmcap
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
			  puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		      @avg_mcap = ActiveRecord::Base.connection.select_all("select round(sum(mcap)/count(*),2) avg_mcap from(SELECT p.schemecode, p.mcap, max( monthend ) FROM `pe_pb_ratios` p JOIN scheme_classifications sc ON p.schemecode = sc.schemecode WHERE sc.classification = (select classification from scheme_classifications where schemecode = "+selected_scheme_code+") GROUP BY p.schemecode) as temp")
			  puts @avg_mcap.length
			  @avg_mcap.each do |am|
				avg_mcap = am['avg_mcap']
			end
		      respond_to do |format|
              format.json {
				render json: {:avg_mcap => @avg_mcap}
			   }
				end
			end
		rescue=> err
			puts err.message
		end
	end
	def portfolio_markettable_allcapavgs
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
			  puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		      @avg_allcap = ActiveRecord::Base.connection.select_all("SELECT round(sum(`lcap_holdpercentage`)/count(*),2) lcap_avg, round(sum(`mcap_holdpercentage`)/count(*),2) mcap_avg, round(sum(`scap_holdpercentage`)/count(*),2) scap_avg, count(*) FROM `scheme_classifications` WHERE `classification` = (select classification from scheme_classifications where schemecode = "+selected_scheme_code+")")
			  puts @avg_allcap.length
			  @avg_allcap.each do |ac|
				avg_lcap = ac['lcap_avg']
				avg_mcap = ac['mcap_avg']
				avg_scap = ac['scap_avg']
			end
		      respond_to do |format|
              format.json {
				render json: {:avg_allcap => @avg_allcap}
			   }
				end
			end
		rescue=> err
			puts err.message
		end
	end

	def navgraph
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
				@nav_sql = "SELECT schemecode, date_format(navdate,'%Y-%m-%d') navdate, round(adjnavrs,2) adjnavrs FROM `navhistfull_adjnavs` WHERE `schemecode` = "+selected_scheme_code+" AND navdate BETWEEN now() - INTERVAL 1 year AND now() ORDER BY navdate ASC"

				@nav_data = ActiveRecord::Base.connection.select_all(@nav_sql)

				adjnavrs_firstday = @nav_data.first['adjnavrs']
				puts "First record stored : " + adjnavrs_firstday.to_s
				@navdate=""
				@nav_value_y = ""
				i=0
				@nav_data.each do |nd|
					adjnavrs = nd['adjnavrs']
					y_value = 100*( adjnavrs - adjnavrs_firstday)/adjnavrs_firstday
					#puts adjnavrs_firstday.to_s+","+adjnavrs.to_s+","+y_value.to_s
					if(i==0)
						@navdate = nd['navdate'].to_s
						@nav_value_y = y_value.round(2).to_s
					else
						@navdate = @navdate.to_s+","+nd['navdate'].to_s
						@nav_value_y = @nav_value_y.to_s+","+y_value.round(2).to_s
					end

					i = i+1
				end
				@navgraph = Array[@navdate,@nav_value_y]
        puts @navgraph
				respond_to do |format|
				format.json {
				render json: {:navgraph => @navgraph}
				}
				end
			end
		rescue=> err
			puts err.message
		end
	end

	def star_rating
		begin
			selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
			  puts "Schemecode Received for Query: " + selected_scheme_code.to_s
		      @star_ratings = ActiveRecord::Base.connection.select_all("SELECT `rupeevest_rating` FROM `rupeevest_ratings` WHERE `schemecode`="+ selected_scheme_code)
					puts @star_ratings
		      respond_to do |format|
               format.json {
				render json: {:star_ratings => @star_ratings}
			   }
			end
		end
		rescue=> err
			puts err.message
		end
	end

	def credit_rating

		begin
			selected_scheme_code = session[:schemecode].to_s
			puts "Schemecode : " +selected_scheme_code,to_s
			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
				@credit_rating_sql = "select round(sum(holdpercentage),2) as  rupeevest_display_name from (SELECT mf.invdate, mf.`holdpercentage` , mf.`rating` , cr.rupeevest_display_name FROM `mf_portfolios` mf JOIN credit_ratings cr ON mf.rating = cr.accord_display_name WHERE mf.schemecode = "+selected_scheme_code+" AND DATE_FORMAT( `invdate` , '%Y-%m-%d' ) = date_format((SELECT max( date_format( invdate, '%Y-%m-%d' ) ) AS invdate FROM mf_portfolios ) , '%Y-%m-%d'))temp group by rupeevest_display_name"
				puts @credit_rating_sql.to_s
				@credit_rating = ActiveRecord::Base.connection.select_all(@credit_rating_sql)
				puts @credit_rating.to_s
				respond_to do |format|
				format.json {
					render json: {:credit_rating => @credit_rating}
			    }
				end
			end
		rescue=> err
			puts err.message
		end
	end
end
