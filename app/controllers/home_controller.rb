class HomeController < ApplicationController
  def show

  end
  def index
	begin

		if request.post?
			selected_scheme_code = params[:schemecode].to_s
			puts "Schemecode Received for Session: " + selected_scheme_code
			session[:schemecode] = selected_scheme_code
			puts session[:schemecode].to_s
			respond_to do |format|
				format.json {
					render json: {:schemecode=>selected_scheme_code}
				}
			end
		end
	rescue => err
		puts err.message

	end
  end


  def index_search
	begin

		if request.post?
			selected_scheme_name = params[:schemename].to_s
			puts "Schemename Received for Session: " + selected_scheme_name
			@schemedata = ActiveRecord::Base.connection.select_all("SELECT schemecode FROM `scheme_classifications` WHERE `s_name` = '" +selected_scheme_name +"'")
			selected_scheme_code=""
			@schemedata.each do |sd|
				selected_scheme_code = sd['schemecode'].to_s
			end
			puts "Schemecode is " +selected_scheme_code
			session[:schemecode] = selected_scheme_code
			puts session[:schemecode].to_s
			respond_to do |format|
				format.json {
					render json: {:schemecode=>selected_scheme_code}
				}
			end
		end
	rescue => err
		puts err.message

	end
  end

	def index_latest

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

				select_sql = "select cm.type from scheme_classifications sc join classification_masters cm on sc.classification = cm.classification where sc.schemecode = "+selected_scheme_code.to_s
				@class_data = ActiveRecord::Base.connection.select_all(select_sql)
				@scheme_class=""
				@class_data.each do |sd|
					@scheme_class = sd['type'].to_s
				end
				puts "Mani : "+@scheme_class.to_s;
				@sql="SELECT sr.`schemecode`,ty.type, sr.`expenceratio`, sr.`fund_manager`, sr.`navchange`, sr.`turnover_ratio`,  sr.`exitload`, sr.`navrs`,date_format( sr.`navdate`, '%Y-%m-%d' ) AS `navdate` , sr.`lockperiod`, date_format( sr.`inception_date`, '%Y-%m-%d' ) AS `inception_date`, sr.`inception_return`, sr.`minimum_investment`, sr.`aumtotal`, sr.`fund_house`, sr.`index_name`, sr.`redemption_period`, sr.`aumdate`, sr.`returns_1month`, sr.`returns_3month`, sr.`returns_1year`, sr.`returns_3year`, sr.`returns_5year`, sr.`ytd_returns`, sr.`highest_sector`,  rr.`portfolio_attributes`, rr.`cost_factor`, rr.`risk`, rr.`consistency_of_return`, rr.`total_return`,sc.`s_name`, sc.`classification`,nh.navrs navrs_gp from scheme_rupeevests sr join rupeevest_ratings rr on sr.schemecode = rr.schemecode join scheme_details_fulls sd on sr.schemecode = sd.schemecode join type_msts ty on sd.type_code = ty.type_code  join scheme_classifications sc on sr.`schemecode`=  sc.`schemecode` join navhistfull_adjnavs nh on sr.schemecode = nh.schemecode and date_format(nh.navdate,'%Y-%m-%d') = (select Date_format(max(navdate),'%Y-%m-%d') from navhistfull_adjnavs where schemecode ="+selected_scheme_code+") where sr.schemecode = " + selected_scheme_code
				puts @sql.to_s
				@schemedata = ActiveRecord::Base.connection.select_all(@sql.to_s)
				puts @schemedata.to_s
				# @schemedata = ActiveRecord::Base.connection.select_all("SELECT sd.schemecode,sd.`s_name`,sd.fund_mgr1,sd.fund_mgr2,sd.fund_mgr3,sd.fund_mgr4, sd.lockperiod, max(sc.exitload) as exitload, max(ex.exratio) as exratio, max(sa.`mininv`) as mininv, date_format(mr.`incdate`,'%Y-%m-%d') as incdate,  round( max( bm.`incret`) , 2 ) AS incret, max(ag.`turnover_ratio`) as turnover_ratio,date_format(cn.`navdate`,'%Y-%m-%d') as navdate , cn.`navrs` , cn.`change` AS navchange,tm.type, scf.classification,sm.total,max(sm.date) as aumdate FROM scheme_details_fulls sd join schemeloads sc on sd.schemecode =sc.schemecode  join expenceratios ex on sd.schemecode = ex.schemecode join scheme_assetallocs sa on sd.schemecode = sa.schemecode join mf_abs_returns mr on sd.schemecode = mr.schemecode join bm_indices_res bm on sd.schemecode = bm.index_code join avg_maturities ag on sd.schemecode = ag.schemecode join currentnavs cn on sd.schemecode = cn.schemecode JOIN type_msts tm ON sd.type_code = tm.type_code JOIN scheme_classifications scf ON sd.schemecode = scf.schemecode join scheme_aums sm on sd.schemecode = sm.schemecode where  sc.schemecode = " + selected_scheme_code)
				respond_to do |format|
					format.json {
					render json: {:schemedata=>@schemedata}
				}
				end

			end

		rescue=> err
			puts err.message
		end
	end

	def get_search_data

       begin
		@search_data = ActiveRecord::Base.connection.select_all("SELECT sc.schemecode,sc.s_name FROM scheme_classifications sc join scheme_rupeevests sr on sc.schemecode = sr.schemecode order by sr.aumtotal desc")


		respond_to do |format|
			format.json {
			render json: {:search_data => @search_data}
		}
		  end
		rescue =>err
		 puts err.message
		end
	end

	def stock_page

	end

	def sector_page

	end

	def get_holding_asset

		begin
         selected_scheme_code = session[:schemecode].to_s

			if(selected_scheme_code == "")

				respond_to do |format|
					format.json {
					render json:{:schemedata=>selected_scheme_code}
				}
				end
			else
				@select_class = "Select sc.schemecode,cm.classification_id from scheme_classifications sc join classification_masters cm on sc.classification = cm.classification where sc.schemecode = "+selected_scheme_code

				@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
				scheme_class = ""
				if(@select_class_data.length > 0)
					@select_class_data.each do |sd|
						scheme_class = sd['classification_id'].to_s
					end
					puts scheme_class.to_s
					if (scheme_class == "1" or scheme_class == "2" or scheme_class == "3" or scheme_class == "4" or scheme_class == "5" or scheme_class == "6" or scheme_class == "19" or  scheme_class == "20" or  scheme_class == "21" or  scheme_class == "22" or  scheme_class == "23" or  scheme_class == "24" or  scheme_class == "25" or  scheme_class == "26" or  scheme_class == "27")
						puts "if"
						@hold_sql = "SELECT mf.schemecode, mf.invdate, round(mf.holdpercentage,2) holdpercentage, round(temp.holdpercentage,2) as prev_holdperc, mf.sect_name, mf.compname,rs.rv_sect_name FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rs ON ri.rv_sect_code = rs.rv_sect_code left outer join (SELECT mf.schemecode, mf.invdate, mf.holdpercentage, mf.sect_name, mf.rating, mf.compname,rs.rv_sect_name FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rs ON ri.rv_sect_code = rs.rv_sect_code WHERE mf.schemecode = "+selected_scheme_code+" AND date_format( mf.invdate, '%Y-%m-%d' ) = date_format( ( SELECT date_format(max(invdate),'%Y-%m-%d') as invdate FROM mf_portfolios WHERE (date_format(invdate,'%Y-%m-%d') between date_format(MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())- 4 QUARTER,'%Y-%m-%d') and date_format((MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())- 3 QUARTER - INTERVAL 1 DAY),'%Y-%m-%d')) and schemecode = "+selected_scheme_code+") , '%Y-%m-%d') ORDER BY mf.holdpercentage desc ) temp on mf.schemecode = temp.schemecode and mf.compname = temp.compname WHERE mf.schemecode = "+selected_scheme_code+" AND date_format( mf.invdate, '%Y-%m-%d' ) = date_format( ( SELECT max( date_format( invdate, '%Y-%m-%d' ) ) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') ORDER BY mf.holdpercentage desc"
					elsif (scheme_class == "7" or scheme_class == "8" or scheme_class == "9" or scheme_class == "10" or scheme_class == "11" or scheme_class == "12")
						puts "elsid"
						@hold_sql = "SELECT mf.schemecode, mf.invdate, round(mf.holdpercentage,2) holdpercentage,round(temp.holdpercentage,2) as prev_holdperc,  mf.rating, mf.compname,am.asect_type FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rs ON ri.rv_sect_code = rs.rv_sect_code left outer join (SELECT mf.schemecode, mf.invdate, mf.holdpercentage, mf.sect_name, mf.rating, mf.compname,rs.rv_sect_name FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rs ON ri.rv_sect_code = rs.rv_sect_code WHERE mf.schemecode = "+selected_scheme_code+" AND date_format( mf.invdate, '%Y-%m-%d' ) = date_format( ( SELECT date_format(max(invdate),'%Y-%m-%d') as invdate FROM mf_portfolios WHERE (date_format(invdate,'%Y-%m-%d') between date_format(MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())- 4 QUARTER,'%Y-%m-%d') and date_format((MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())- 3 QUARTER - INTERVAL 1 DAY),'%Y-%m-%d')) and schemecode = "+selected_scheme_code+") , '%Y-%m-%d') ORDER BY mf.holdpercentage desc ) temp on mf.schemecode = temp.schemecode and mf.compname = temp.compname join asect_mst_news am on mf.asect_code = am.asect_code WHERE mf.schemecode = "+selected_scheme_code+" AND date_format( mf.invdate, '%Y-%m-%d' ) = date_format( ( SELECT max( date_format( invdate, '%Y-%m-%d' ) ) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') ORDER BY mf.holdpercentage desc"
					elsif (scheme_class == "13" or scheme_class == "14" or scheme_class == "15" or scheme_class == "16")
						@hold_sql = "SELECT mf.schemecode, mf.invdate, round(mf.holdpercentage,2) holdpercentage, round(temp.holdpercentage,2) as prev_holdperc, mf.sect_name, mf.compname,rs.rv_sect_name FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rs ON ri.rv_sect_code = rs.rv_sect_code left outer join (SELECT mf.schemecode, mf.invdate, mf.holdpercentage, mf.sect_name, mf.rating, mf.compname,rs.rv_sect_name FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rs ON ri.rv_sect_code = rs.rv_sect_code WHERE mf.schemecode = "+selected_scheme_code+" AND date_format( mf.invdate, '%Y-%m-%d' ) = date_format( ( SELECT date_format(max(invdate),'%Y-%m-%d') as invdate FROM mf_portfolios WHERE (date_format(invdate,'%Y-%m-%d') between date_format(MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())- 4 QUARTER,'%Y-%m-%d') and date_format((MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())- 3 QUARTER - INTERVAL 1 DAY),'%Y-%m-%d')) and schemecode = "+selected_scheme_code+") , '%Y-%m-%d') ORDER BY mf.holdpercentage desc ) temp on mf.schemecode = temp.schemecode and mf.compname = temp.compname WHERE mf.schemecode = "+selected_scheme_code+" AND date_format( mf.invdate, '%Y-%m-%d' ) = date_format( ( SELECT max( date_format( invdate, '%Y-%m-%d' ) ) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') ORDER BY mf.holdpercentage desc"
					else

					end
					@hold = ActiveRecord::Base.connection.select_all(@hold_sql.to_s)


					else

					end


				puts scheme_class
						respond_to do |format|
							format.json {
							render json: {:hold => @hold}
						}
					end
			end
		rescue =>err
		    puts err.message
	   end
    end

	  def get_sector_data


		   begin
		   if request.post?
				puts "Inside get_search_data fn"
				selected_sector = params[:sectorname].to_s
				sector_sql = "SELECT rh.schemecode,sc.s_name,case when rh.hold_perc is null then 0 else round(rh.hold_perc,2) end hold_perc,case when rh.hold_perc_q1 is null then 0 else round( rh.hold_perc_q1,2) end hold_perc_q1,case when rh.hold_perc_q2 is null then 0 else round( rh.hold_perc_q2,2) end hold_perc_q2,case when rh.hold_perc_q3 is null then 0 else round( rh.hold_perc_q3,2) end hold_perc_q3,case when rh.hold_perc_q4 is null then 0 else round( rh.hold_perc_q4,2) end hold_perc_q4,case when rh.hold_perc_q5 is null then 0 else round( rh.hold_perc_q5,2) end hold_perc_q5, rs.rv_sect_name FROM rupeevest_sect_holdpercs rh join rupeevest_sectors rs on rh.rv_sect_code= rs.rv_sect_code join scheme_classifications sc on rh.schemecode = sc.schemecode where rs.rv_sect_name = '"+selected_sector+"' order by rh.hold_perc ,sc.s_name  desc limit 10"
           		@sec = ActiveRecord::Base.connection.select_all(sector_sql)
		       respond_to do |format|
			    format.json {
				  render json: {:sec => @sec}
			      }
		       end
			end
			rescue =>err
				puts err.message
		    end
		end

		def get_sector_search

		   begin
				#sec_sql = "SELECT rh.`schemecode`,sc.`s_name`, round(rh.`hold_perc`,2) as `hold_perc`, round( rh.`hold_perc_q1`,2) as `hold_perc_q1`, round (rh.`hold_perc_q2`,2) as `hold_perc_q2`, round(`hold_perc_q3`,2) as `hold_perc_q3`, round(`hold_perc_q4`,2) as`hold_perc_q4`, round(`hold_perc_q5`,2) as `hold_perc_q5`, rs.`rv_sect_name` FROM `rupeevest_sect_holdpercs` rh join rupeevest_sectors rs on rh.`rv_sect_code`= rs.`rv_sect_code` join scheme_classifications sc on rh.`schemecode` = sc.`schemecode` order by  rs.`rv_sect_name`"

				sec_sql = "SELECT rv_sect_code, rv_sect_name FROM rupeevest_sectors"
           		@secsearch = ActiveRecord::Base.connection.select_all(sec_sql)
		       respond_to do |format|
			    format.json {
				  render json: {:secsearch => @secsearch}
			      }
		       end
		        rescue =>err
		        puts err.message
		   end
		end


    

	def get_stock_data

		begin
			if request.post?
				selected_stock = params[:stockname].to_s
				selected_stocks = selected_stock.split("|")
				st_sql = "Select fincode from mf_companymasters where compname = '"+selected_stocks[0]+"' and s_name = '"+selected_stocks[1]+"'"
				puts st_sql
				get_fincode = ActiveRecord::Base.connection.select_all(st_sql)
				fincode = 0
				puts get_fincode.length
				get_fincode.each do |gf|
					fincode = gf['fincode'].to_s
					puts fincode
				end
				@stock = ActiveRecord::Base.connection.select_all("SELECT mc.fincode, mc.compname, mc.s_name as name,round (mf.holdpercentage,2) as holdpercentage, DATE_FORMAT (mf.invdate,' %D %M %Y') invdate, mf.schemecode, sd.s_name FROM `mf_companymasters` mc JOIN mf_portfolios mf ON mc.fincode = mf.fincode JOIN scheme_details_fulls sd ON mf.schemecode = sd.schemecode WHERE mc.fincode = "+fincode+" AND DATE_FORMAT( mf.`invdate` , '%Y-%m-%d' ) = date_format( (SELECT max( date_format( invdate, '%Y-%m-%d' ) ) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') ORDER BY mf.holdpercentage DESC ")
        puts @stock
				respond_to do |format|
				format.json {
				  render json: {:stock => @stock}
				}
				end
			end
			rescue =>err
		  puts err.message

		end
    end

	def get_stock_search

		   begin

           		@stocksearch = ActiveRecord::Base.connection.select_all("SELECT fincode, compname, s_name, ind_code, status FROM mf_companymasters WHERE ind_code > 0 and ind_code < 200 and ind_code not in (74,113,142,147,153,154) and status = 'active'")
		       respond_to do |format|
			    format.json {
				  render json: {:stocksearch => @stocksearch}
			      }
		       end
		        rescue =>err
		        puts err.message
		   end
		end

	def get_landing_fundmanager

   	begin

		@fundman = ActiveRecord::Base.connection.select_all("SELECT distinct(`fund_manager`) FROM `scheme_rupeevests`")
	   puts@fundman


			respond_to do |format|
			format.json {
			  render json: {:fundman => @fundman}
			}
			end
			rescue =>err
		  puts err.message

		end
	 end

	 def get_landing_amc

		begin

			@amcn = ActiveRecord::Base.connection.select_all("SELECT distinct (`amc`) FROM `amc_msts` limit 10")
				puts@amcn


				respond_to do |format|
				format.json {
				  render json: {:amcn => @amcn}
				}
				end
				rescue =>err
			  puts err.message

			end
	 end

	 def get_landing_index

		begin

			@index = ActiveRecord::Base.connection.select_all("SELECT distinct(`index_name`) FROM `scheme_rupeevests`")
				puts@index


				respond_to do |format|
				format.json {
				  render json: {:index => @index}
				}
				end
				rescue =>err
			  puts err.message

			end
	 end

	 def get_landing_returns

		begin
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

		@sql="SELECT case when sc.s_name is null then 0 else sc.s_name end s_name,case when sc.classification is null then 0 else sc.classification end classification,case when rr.`schemecode` is null then 0 else rr.`schemecode` end `schemecode`, case when rr.`return_year1` is null then 0 else round( rr.return_year1 , 2 ) end  return_year1, case when rr.`return_year2` is null then 0 else round( rr.return_year2 , 2 ) end `return_year2`,case when rr.`return_year3` is null then 0 else round( rr.return_year3 , 2 ) end `return_year3`, case when rr.`return_year4` is null then 0 else round( rr.return_year4 , 2 ) end `return_year4`,case when rr.`return_year5` is null then 0 else round( rr.return_year5 , 2 ) end `return_year5`,case when rr.`return_year6` is null then 0 else round( rr.return_year6 , 2 ) end `return_year6`,case when rr.`return_year7` is null then 0 else round( rr.return_year7 , 2 ) end `return_year7`,case when rr.`return_year8` is null then 0 else round( rr.return_year8 , 2 ) end `return_year8`,case when rr.`return_year9` is null then 0 else round( rr.return_year9 , 2 ) end `return_year9`,case when rr.`return_year10` is null then 0 else round( rr.return_year10 , 2 ) end `return_year10`, case when rr.`return_month1` is null then 0 else round( rr.return_month1 , 2 ) end `return_month1`, case when rr.`return_month2` is null then 0 else round( rr.return_month2 , 2 ) end `return_month2`, case when rr.`return_month3` is null then 0 else round( rr.return_month3 , 2 ) end `return_month3`,case when rr.`return_month4` is null then 0 else round( rr.return_month4 , 2 ) end `return_month4`, case when rr.`return_month5` is null then 0 else round( rr.return_month5 , 2 ) end `return_month5`, case when rr.`return_month6` is null then 0 else round( rr.return_month6 , 2 ) end `return_month6`, case when rr.`return_month7` is null then 0 else round( rr.return_month7 , 2 ) end `return_month7`, case when rr.`return_month8` is null then 0 else round( rr.return_month8 , 2 ) end `return_month8`, case when rr.`return_month9` is null then 0 else round( rr.return_month9 , 2 ) end `return_month9`, case when rr.`return_month10` is null then 0 else round( rr.return_month10 , 2 ) end `return_month10`,case when rr.`return_quarter1` is null then 0 else round( rr.return_quarter1 , 2 ) end `return_quarter1`,case when rr.`return_quarter2` is null then 0 else round( rr.return_quarter2 , 2 ) end `return_quarter2`,case when rr.`return_quarter3` is null then 0 else round( rr.return_quarter3 , 2 ) end `return_quarter3`, case when rr.`return_quarter4` is null then 0 else round( rr.return_quarter4 , 2 ) end `return_quarter4`, case when rr.`return_quarter5` is null then 0 else round( rr.return_quarter5 , 2 ) end `return_quarter5`, case when rr.`return_quarter6` is null then 0 else round( rr.return_quarter6 , 2 ) end `return_quarter6`,case when rr.`return_quarter7` is null then 0 else round( rr.return_quarter7 , 2 ) end `return_quarter7`, case when rr.`return_quarter8` is null then 0 else round( rr.return_quarter8 , 2 ) end `return_quarter8`, case when rr.`return_quarter9` is null then 0 else round( rr.return_quarter9 , 2 ) end `return_quarter9`, case when rr.`return_quarter10` is null then 0 else round( rr.return_quarter10 , 2 ) end `return_quarter10`   FROM scheme_classifications sc join rupeevest_returns rr  on sc.schemecode = rr.schemecode join classification_masters cm on sc.classification= cm.classification join `rupeevest_returns_catavgs` ca on  cm.`classification_id`= ca.`classification_id`  where sc.classification = 'Equity : Large Cap' group by sc.schemecode"
		puts @sql.to_s
		@return_tab = ActiveRecord::Base.connection.select_all( @sql.to_s)

			respond_to do |format|
			format.json {
			  render json: {:return_tab => @return_tab,:ten_yrs=>ten_yrs,:ten_months=>ten_months,:ten_quarters=>ten_quarters}
			}
			end
			rescue =>err
		  puts err.message

		end
	end

    def filters_values

	begin

		@sql="SELECT min(expenceratio) exp_ratio_min, max(expenceratio) exp_ratio_max, min(turnover_ratio) turnover_ratio_min, max(turnover_ratio) turnover_ratio_max,  min(exitload) exitload_min, max(exitload) exitload_max, min(aumtotal) aumtotal_min, max(aumtotal) aumtotal_max, min(inception_date) incep_date_min, max(inception_date) incep_date_max FROM scheme_rupeevests"
		puts @sql.to_s
		@filters_values = ActiveRecord::Base.connection.select_all( @sql.to_s)
		puts@filters_values

			respond_to do |format|
			format.json {
			  render json: {:filters_values => @filters_values}
			}
			end
			rescue =>err
		  puts err.message

		end
	end

	def yrs
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


	end
	def quarter_dates(offset)
		date = Date.today << (offset * 3)
		[(date.beginning_of_quarter).strftime("%b %y"), (date.end_of_quarter).strftime("%b %y")]
		puts quarter_dates(0) #=> [Tue, 01 Apr 2014, Mon, 30 Jun 2014]
			puts quarter_dates(1) #=> [Wed, 01 Jan 2014, Mon, 31 Mar 2014]
			puts quarter_dates(9) #=> [Sun, 01 Jan 2012, Sat, 31 Mar 2012]
	end
end
