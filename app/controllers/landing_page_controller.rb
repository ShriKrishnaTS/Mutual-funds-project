class LandingPageController < ApplicationController

	def homedata
		begin
			@scheme_codes = 	ActiveRecord::Base.connection.select_all ("select schemecode from scheme_classifications")
			@i = 0
			@scheme_codes.each do |sc|
			@i = @i + 1
				@schemecode = sc['schemecode'].to_s
				puts @schemecode
				@expence_ratios = ActiveRecord::Base.connection.select_all ("SELECT DATE_FORMAT(date,'%Y-%m-%d') as date, round(exratio,2) as exratio FROM expenceratios WHERE schemecode = "+@schemecode+" order by date desc")
				@expence_ratios.each do |er|
					if !(er['exratio'].blank?)
						@expenceratio = er['exratio'].to_f
						@expencedate = er['date']
						puts @expenceratio.to_s
						puts @expencedate.to_s
						break
					end
				end

				#@turnover_ratios = ActiveRecord::Base.connection.select_all ("SELECT DATE_FORMAT(date,'%Y-%m-%d') as date, round(turnover_ratio,2) as turnover_ratio FROM avg_maturities WHERE schemecode = "+@schemecode+" ORDER BY date desc limit 1")

				# Corrected Query
				@turnover_ratios = ActiveRecord::Base.connection.select_all ("SELECT DATE_FORMAT(am.date,'%Y-%m-%d') as date, round(am.turnover_ratio,2) as turnover_ratio FROM avg_maturities am join scheme_details_fulls sdf on am.schemecode = sdf.primary_fd_code WHERE sdf.schemecode = "+@schemecode+" ORDER BY date desc limit 1")

				@turnover_ratios.each do |tr|
				puts tr['turnover_ratio']
					if !(tr['turnover_ratio'].to_s.strip == "")
						@turnover_ratio = (tr['turnover_ratio']*100).round(2).to_f
						@turnover_date = tr['date']
						puts "inside if of turnover ratio"
						break
					else
						@turnover_ratio = "0"
						@turnover_date = "0000-00-00"
					end
					puts "turn over date " + @turnover_date.to_s
					puts "Turn Over ratio " + @turnover_ratio.to_s
				end

				@exit_loads = ActiveRecord::Base.connection.select_all ("SELECT DATE_FORMAT(ldate,'%Y-%m-%d') as ldate, exitload, remarks, ltypecode FROM schemeloads WHERE schemecode = "+@schemecode+" AND ltypecode = 2 ORDER BY ldate DESC limit 1")
				puts "Exitload fnty"
				@exit_loads.each do |el|
					if !(el['remarks'].blank?)
						@exit_load = el['exitload']
						@remarks = "if exited before 1 Year, Nil after 1 year"
						@exitload_date = el['ldate']
						puts @exitload_date
						puts @exit_load.to_s
						puts @remarks
						break
					else
						@exit_load = el['exitload']
						@remarks = el['remarks']
						@exitload_date = el['ldate']
						puts @exitload_date
						puts @exit_load.to_s
						puts @remarks
						break
					end
				end

				@inception_returns= ActiveRecord::Base.connection.select_all ("SELECT round( incret , 2 ) AS incret, DATE_FORMAT( c_date , '%Y-%m-%d' ) AS c_date, incdate FROM mf_returns WHERE schemecode = "+@schemecode+" ORDER BY c_date DESC limit 1")
				@inception_returns.each do |ir|
					if !(ir['c_date'].blank?)
						@inception_return = ir['incret']
						puts @inception_return
						break
					end
				end

				@scheme_details = ActiveRecord::Base.connection.select_all ("SELECT sdf.lockperiod, DATE_FORMAT(sdf.incept_date,'%Y-%m-%d') as incept_date, sdf.mininvt, sdf.red, sdf.fund_mgr1, sdf.amc_code, am.amc FROM scheme_details_fulls sdf JOIN amc_msts am ON sdf.amc_code = am.amc_code WHERE schemecode = "+@schemecode)
				@scheme_details.each do |sd|
					if !(sd['lockperiod'].to_s.strip == "")
						@lock_period = sd['lockperiod'] #Years
					else
						@lock_period = "0"
					end
					@incept_date = sd['incept_date']
					@min_investment = sd['mininvt']
					@redemption_period = sd['red'].strip #days
					@fund_mgr = sd['fund_mgr1']
					@fund_house = sd['amc']
					puts @lock_period.to_s
					puts @incept_date
					puts @min_investment
					puts @redemption_period
					puts @fund_mgr
					puts @fund_house

				end

				@nav_values = ActiveRecord::Base.connection.select_all ("SELECT navrs,DATE_FORMAT(max(navdate),'%Y-%m-%d') as navdate,round(`change`,2) as navchange FROM currentnavs WHERE schemecode =  "+@schemecode)
				#@nav_values = ActiveRecord::Base.connection.select_all ("SELECT navrs,DATE_FORMAT(max(navdate),'%Y-%m-%d') as navdate FROM currentnavs WHERE schemecode =  "+schemecode)
				@nav_values.each do |nv|
					if !(nv['navdate'].blank?)
						@navrs = nv['navrs']
						@navdate = nv['navdate']
						@navchange = nv['navchange']
						puts @navrs
						puts @navdate
						puts @navchange
						break
					end
				end

				@aum_total= ActiveRecord::Base.connection.select_all ("SELECT DATE_FORMAT(date,'%Y-%m-%d') as aumdate,total FROM scheme_aums WHERE schemecode = "+@schemecode +" order by date desc")
				@aum_total.each do |at|
					if !(at['aumdate'].blank?)
						@aum_date = at['aumdate']
						@aum_value = at['total']
						puts @aum_date
						puts @aum_value
						break
					end
				end

				@index_names= ActiveRecord::Base.connection.select_all ("SELECT si.indexcode,im.indexname FROM scheme_indices si JOIN index_msts im on si.indexcode = im.indexcode WHERE si.schemecode = "+@schemecode)
				@index_names.each do |im|
					if !(im['indexcode'].blank?)
						@index_code = im['indexcode']
						@index_name = im['indexname']
						puts @index_code
						puts @index_name
						break
					end
				end

				#@highest_sector_data = ActiveRecord::Base.connection.select_all ("SELECT `invdate` , sum( `perc_hold` ) AS perc_hold, `sect_code` , `sect_name` FROM `sect_allocations` WHERE `schemecode` ="+@schemecode.to_s+" AND DATE_FORMAT( `invdate` , '%Y-%m-%d' ) = date_format((select max(date_format(invdate,'%Y-%m-%d')) as invdate from sect_allocations),'%Y-%m-%d') GROUP BY `sect_code` ORDER BY perc_hold DESC limit 1")

				#Corrected Query

				@highest_sector_data = ActiveRecord::Base.connection.select_all("SELECT sa.`invdate`, sum( sa.`perc_hold` ) AS perc_hold, sa.`sect_code`, sa.`sect_name` FROM `sect_allocations` sa join scheme_details_fulls sdf on sa.schemecode = sdf.primary_fd_code WHERE sdf.`schemecode` = "+@schemecode+" AND DATE_FORMAT( sa.`invdate` , '%Y-%m-%d' ) = date_format((select max(date_format(invdate,'%Y-%m-%d')) as invdate from sect_allocations),'%Y-%m-%d') GROUP BY sa.`sect_code` ORDER BY perc_hold DESC limit 1")

				@highest_sector_data.each do |hs|
					@highest_sector = hs['sect_name']
					puts @highest_sector
				end
				@select_sql = "Select * from scheme_rupeevests where schemecode = "+@schemecode.to_s
				@select_data = ActiveRecord::Base.connection.select_all (@select_sql)
				if @select_data.length > 0

					@update_qry = "Update scheme_rupeevests set expenceratio = "+@expenceratio.to_s+", expenceratio_date = date_format('"+@expencedate.to_s+"','%Y-%m-%d'),turnover_ratio = "+@turnover_ratio.to_s+", turnover_date = date_format('"+@turnover_date.to_s+"','%Y-%m-%d'),exitload_date = date_format('"+@exitload_date.to_s+"','%Y-%m-%d'),exitload = "+@exit_load.to_s+",exitload_remarks = '"+@remarks.to_s+"', inception_date = date_format('"+@incept_date.to_s+"','%Y-%m-%d'), inception_return = "+@inception_return.to_s+", lockperiod = "+@lock_period.to_s+", minimum_investment = "+@min_investment.to_s+", redemption_period = "+@redemption_period.to_s+", fund_manager = '"+@fund_mgr.to_s+"',fund_house = '"+@fund_house.to_s+"' ,navrs = "+@navrs.to_s+", navchange = "+@navchange.to_s+", navdate = date_format('"+@navdate.to_s+"','%Y-%m-%d'),aumdate = date_format('"+@aum_date.to_s+"','%Y-%m-%d'), aumtotal = "+@aum_value.to_s+", index_code = "+@index_code.to_s+", index_name = '"+@index_name.to_s+"', highest_sector = '"+@highest_sector.to_s+"' where schemecode = "+@schemecode.to_s
					puts @update_qry.to_s
					@update = ActiveRecord::Base.connection.update(@update_qry)
				else
					@insert_qry = "Insert into scheme_rupeevests(schemecode, expenceratio_date, expenceratio, turnover_ratio, turnover_date, exitload_date, exitload, exitload_remarks, inception_date, inception_return, lockperiod, minimum_investment, redemption_period, fund_manager,fund_house, navrs, navchange, navdate, aumdate, aumtotal, index_code, index_name,highest_sector)values("+@schemecode.to_s+",date_format('"+@expencedate.to_s+"','%Y-%m-%d'),"+@expenceratio.to_s+","+@turnover_ratio.to_s+",date_format('"+@turnover_date.to_s+"','%Y-%m-%d'),date_format('"+@exitload_date.to_s+"','%Y-%m-%d'),"+@exit_load.to_s+",'"+@remarks.to_s+"',date_format('"+@incept_date.to_s+"','%Y-%m-%d'),"+@inception_return.to_s+","+@lock_period.to_s+","+@min_investment.to_s+","+@redemption_period.to_s+",'"+@fund_mgr.to_s+"','"+@fund_house.to_s+"',"+@navrs.to_s+","+@navchange.to_s+",date_format('"+@navdate.to_s+"','%Y-%m-%d'),date_format('"+@aum_date.to_s+"','%Y-%m-%d'),"+@aum_value.to_s+","+@index_code.to_s+",'"+@index_name.to_s+"','"+@highest_sector.to_s+"')"
					puts @insert_qry.to_s
					@insert = ActiveRecord::Base.connection.insert(@insert_qry)

				end
				puts @i.to_s


				# sr = SchemeRupeevest.new
				# sr.schemecode = @schemecode
				# puts "Mani11"
				# sr.expenceratio_date = DateTime.strptime(@expencedate,'%Y-%m-%d').to_formatted_s(:db)
				# puts "Mani12"
				# sr.expenceratio = @expenceratio
				# puts "Mani13"
				# sr.turnover_date = DateTime.strptime(@turnover_date,'%Y-%m-%d').to_formatted_s(:db)
				# puts "Mani14"
				# sr.turnover_ratio = @turnover_ratio
				# puts "Mani15"
				# sr.exitload_date = DateTime.strptime(@exitload_date,'%Y-%m-%d').to_formatted_s(:db)
				# sr.exitload = @exit_load
				# sr.exitload_remarks = @remarks
				# sr.inception_date = DateTime.strptime(@incept_date,'%Y-%m-%d').to_formatted_s(:db)
				# sr.inception_return = @inception_return
				# sr.lockperiod = @lock_period
				# sr.minimum_investment = @min_investment
				# sr.redemption_period = @redemption_period
				# sr.fund_manager = @fund_mgr
				# sr.fund_house = @fund_house
				# sr.navrs = @navrs
				# sr.navchange = @navchange
				# sr.navdate = DateTime.strptime(@navdate,'%Y-%m-%d').to_formatted_s(:db)
				# sr.aumdate = DateTime.strptime(@aum_date,'%Y-%m-%d').to_formatted_s(:db)
				# sr.aumtotal = @aum_value
				# sr.index_code = @index_code
				# sr.index_name = @index_name
				# sr.highest_sector = @highest_sector
				# sr.save
				puts @schemecode + " saved"
			end
		rescue=> err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end
	def rupeevest_category_returns
	@logfile = "rupeevest_category_returns"
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
		begin
			@classifications = ActiveRecord::Base.connection.select_all("SELECT classification_id,classification from classification_masters order by classification_id asc")
			puts @classifications.length

			@classifications.each do |cs|

				@classification_id = cs['classification_id']
				@classification = cs['classification']
				puts @classification
				ytd_returns(@classification,@classification_id)
				month1_returns(@classification,@classification_id)
				month3_returns(@classification,@classification_id)
				year1_returns(@classification,@classification_id)
				year3_returns(@classification,@classification_id)
				year5_returns(@classification,@classification_id)

			end
		rescue => err
			puts err.message
			lc.writelog(err.message,@logfile)
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def rupeevest_category_riskmeasures
		begin
			@classifications = ActiveRecord::Base.connection.select_all("SELECT classification_id,classification from classification_masters order by classification_id asc")
			puts @classifications.length
			@classifications.each do |cs|

				@classification_id = cs['classification_id']
				@classification = cs['classification']
				puts @classification
				std_devxy(@classification_id,@classification.to_s)
				sharpexy(@classification_id,@classification.to_s)
				sotinoxy(@classification_id,@classification.to_s)
				betaxy(@classification_id,@classification.to_s)
				alphaxy(@classification_id,@classification.to_s)
				treynor_ratio_xy(@classification_id,@classification.to_s)
			end
		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def aqm_returns_year_ranking
		begin
			@select_class_sql = "Select * from classification_masters order by classification_id asc"
			@class_data =  ActiveRecord::Base.connection.select_all(@select_class_sql)
			puts @class_data.length
			@class_data.each do |cd|
				@classification = cd['classification']
				@classification_id = cd['classification_id']
				@index = 0
				(1..10).each do |rr|
				@index = @index + 1
				puts rr.to_i
					@select_rank_sql = "select rr.return_year"+@index.to_s+",rr.schemecode from rupeevest_returns rr join scheme_classifications sc on rr.schemecode = sc.schemecode where sc.classification = '"+@classification.to_s+"' and rr.return_year"+@index.to_s+" is not null order by rr.return_year"+@index.to_s+" desc"
					puts @select_rank_sql
					@year_rankdata = ActiveRecord::Base.connection.select_all(@select_rank_sql)
					@year_ranking = 0
					@year_rankdata.each do |yr|
						@schemecode = yr['schemecode']
						@year_ranking = @year_ranking + 1
						@update_rank_sql = "Update rupeevest_returns set rank_year"+@index.to_s+" = "+@year_ranking.to_s+" where schemecode = "+@schemecode.to_s
						puts @update_rank_sql.to_s
						@update_rank = ActiveRecord::Base.connection.update(@update_rank_sql)
					end
					@avg_year_sql = "select count(*),(sum(rr.return_year"+@index.to_s+")/count(*)) as avg_year,cm.classification_id from rupeevest_returns rr join scheme_classifications sc on rr.schemecode = sc.schemecode join classification_masters cm on sc.classification = cm.classification where sc.classification = '"+@classification.to_s+"'"
					puts @avg_year_sql
					@avg_yr_rtns = 0
					@avg_year = ActiveRecord::Base.connection.select_all(@avg_year_sql)
					@avg_year.each do |ay|
						@avg_yr_rtns = ay['avg_year']
						puts @avg_yr_rtns.to_s
						if(!(@avg_yr_rtns.blank?))
							@select_sql = "Select * from rupeevest_returns_catavgs where classification_id = "+@classification_id.to_s
							@select_sql_data =  ActiveRecord::Base.connection.select_all(@select_sql)
							if(@select_sql_data.length > 0)
								@update_sql = "Update rupeevest_returns_catavgs set avg_year"+@index.to_s+" = "+@avg_yr_rtns.to_s+" where classification_id = "+@classification_id.to_s
								puts @update_sql
								@update_avg = ActiveRecord::Base.connection.update(@update_sql)
							else
								@insert_sql = "Insert into rupeevest_returns_catavgs(classification_id,avg_year"+@index.to_s+")values("+@classification_id.to_s+","+@avg_yr_rtns.to_s+")"
								puts @insert_sql
								@insert_avg = ActiveRecord::Base.connection.insert(@insert_sql)
							end
						end
					end
				end
			end
		rescue=>err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def aqm_returns_quarter_ranking
		begin
			@select_class_sql = "Select * from classification_masters order by classification_id asc"
			@class_data =  ActiveRecord::Base.connection.select_all(@select_class_sql)
			puts @class_data.length
			@class_data.each do |cd|
				@classification = cd['classification']
				@classification_id = cd['classification_id']
				@index = 0
				(1..10).each do |rr|
				@index = @index + 1
				puts rr.to_i
					@select_rank_sql = "select rr.return_quarter"+@index.to_s+",rr.schemecode from rupeevest_returns rr join scheme_classifications sc on rr.schemecode = sc.schemecode where sc.classification = '"+@classification.to_s+"' and rr.return_quarter"+@index.to_s+" is not null order by rr.return_quarter"+@index.to_s+" desc"
					puts @select_rank_sql
					@quarter_rankdata = ActiveRecord::Base.connection.select_all(@select_rank_sql)
					@quarter_ranking = 0
					@quarter_rankdata.each do |mr|
						@schemecode = mr['schemecode']
						@quarter_ranking = @quarter_ranking + 1
						@update_rank_sql = "Update rupeevest_returns set rank_quarter"+@index.to_s+" = "+@quarter_ranking.to_s+" where schemecode = "+@schemecode.to_s
						puts @update_rank_sql.to_s
						@update_rank = ActiveRecord::Base.connection.update(@update_rank_sql)
					end
					@avg_qrtr_sql = "select count(*),(sum(rr.return_quarter"+@index.to_s+")/count(*)) as avg_quarter,cm.classification_id from rupeevest_returns rr join scheme_classifications sc on rr.schemecode = sc.schemecode join classification_masters cm on sc.classification = cm.classification where sc.classification = '"+@classification.to_s+"'"
					puts @avg_qrtr_sql
					@avg_qr_rtns = 0
					@avg_quarter = ActiveRecord::Base.connection.select_all(@avg_qrtr_sql)
					@avg_quarter.each do |aq|
						@avg_qr_rtns = aq['avg_quarter']
						puts @avg_qr_rtns.to_s
						if(!(@avg_qr_rtns.blank?))
							@select_sql = "Select * from rupeevest_returns_catavgs where classification_id = "+@classification_id.to_s
							@select_sql_data =  ActiveRecord::Base.connection.select_all(@select_sql)
							if(@select_sql_data.length > 0)
								@update_sql = "Update rupeevest_returns_catavgs set avg_quarter"+@index.to_s+" = "+@avg_qr_rtns.to_s+" where classification_id = "+@classification_id.to_s
								puts @update_sql
								@update_avg = ActiveRecord::Base.connection.update(@update_sql)
							else
								@insert_sql = "Insert into rupeevest_returns_catavgs(classification_id,avg_quarter"+@index.to_s+")values("+@classification_id.to_s+","+@avg_qr_rtns.to_s+")"
								puts @insert_sql
								@insert_avg = ActiveRecord::Base.connection.insert(@insert_sql)
							end
						end
					end
				end
			end
		rescue=>err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def aqm_returns_month_ranking
		begin
			@select_class_sql = "Select * from classification_masters order by classification_id asc"
			@class_data =  ActiveRecord::Base.connection.select_all(@select_class_sql)
			puts @class_data.length
			@class_data.each do |cd|
				@classification = cd['classification']
				@classification_id = cd['classification_id']
				@index = 0
				(1..10).each do |rr|
				@index = @index + 1
				puts rr.to_i
					@select_rank_sql = "select rr.return_month"+@index.to_s+",rr.schemecode from rupeevest_returns rr join scheme_classifications sc on rr.schemecode = sc.schemecode where sc.classification = '"+@classification.to_s+"' and rr.return_month"+@index.to_s+" is not null order by rr.return_month"+@index.to_s+" desc"
					puts @select_rank_sql
					@month_rankdata = ActiveRecord::Base.connection.select_all(@select_rank_sql)
					@month_ranking = 0
					# @month_rankdata.each do |mr|
						# @schemecode = mr['schemecode']
						# @month_ranking = @month_ranking + 1
						# @update_rank_sql = "Update rupeevest_returns set rank_month"+@index.to_s+" = "+@month_ranking.to_s+" where schemecode = "+@schemecode.to_s
						# puts @update_rank_sql.to_s
						# @update_rank = ActiveRecord::Base.connection.update(@update_rank_sql)
					# end
					@avg_month_sql = "select count(*),(sum(rr.return_month"+@index.to_s+")/count(*)) as avg_month,cm.classification_id from rupeevest_returns rr join scheme_classifications sc on rr.schemecode = sc.schemecode join classification_masters cm on sc.classification = cm.classification where sc.classification = '"+@classification.to_s+"'"
					puts @avg_month_sql
					@avg_mth_rtns = 0
					@avg_month = ActiveRecord::Base.connection.select_all(@avg_month_sql)
					@avg_month.each do |aq|
						@avg_mth_rtns = aq['avg_month']
						puts @avg_mth_rtns.to_s
						if(!(@avg_mth_rtns.blank?))
							@select_sql = "Select * from rupeevest_returns_catavgs where classification_id = "+@classification_id.to_s
							@select_sql_data =  ActiveRecord::Base.connection.select_all(@select_sql)
							if(@select_sql_data.length > 0)
								@update_sql = "Update rupeevest_returns_catavgs set avg_month"+@index.to_s+" = "+@avg_mth_rtns.to_s+" where classification_id = "+@classification_id.to_s
								puts @update_sql
								@update_avg = ActiveRecord::Base.connection.update(@update_sql)
							else
								@insert_sql = "Insert into rupeevest_returns_catavgs(classification_id,avg_month"+@index.to_s+")values("+@classification_id.to_s+","+@avg_mth_rtns.to_s+")"
								puts @insert_sql
								@insert_avg = ActiveRecord::Base.connection.insert(@insert_sql)
							end
						end
					end
				end
			end
		rescue=>err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def annual_returns_10years

		begin
			@select_schemes_sql = "Select schemecode from scheme_classifications"
			@select_schemes = ActiveRecord::Base.connection.select_all(@select_schemes_sql)
			@select_schemes.each do |ss|
				@schemecode = ss['schemecode'].to_i
				(1..10).each do |noy|
				puts noy.to_i
					@nav_sql = "SELECT sc.schemecode, min( date_format(nh.navdate,'%Y-%m-%d') ) AS mindate, max( date_format(nh.navdate,'%Y-%m-%d') ) maxdate FROM `scheme_classifications` sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode WHERE year( navdate ) = year( current_date ) -"+noy.to_s+" and nh.schemecode = "+@schemecode.to_s
					puts @nav_sql.to_s
					@select_navdata = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)
					@select_navdata.each do |nd|
						@firstday_navrs = 0
						@lastday_navrs = 0
						@nav_mindate = nd['mindate'].to_s
						@nav_maxdate = nd['maxdate'].to_s
						@navdata_sql = "SELECT * FROM `navhistfull_adjnavs` WHERE (date_format(navdate,'%Y-%m-%d') = date_format('"+@nav_mindate.to_s+"','%Y-%m-%d') or date_format(navdate,'%Y-%m-%d') = date_format('"+@nav_maxdate.to_s+"','%Y-%m-%d')) and schemecode = "+@schemecode.to_s+" order by navdate asc"
						@select_yearsdata = ActiveRecord::Base.connection.select_all(@navdata_sql.to_s)
						@i = 0
						if (@select_yearsdata.length > 0 )
							@select_yearsdata.each do |sy|
							puts @i
								if(@i == 0)
									@firstday_navrs = sy['adjnavrs'].to_f
									@i = @i + 1
								else
									@lastday_navrs = sy['adjnavrs'].to_f
									@i = 0
								end
							end

							@periodic_return = (@lastday_navrs - @firstday_navrs)/@firstday_navrs * 100
							puts @periodic_return
							@select_returns_sql = "Select * from rupeevest_returns where schemecode = "+@schemecode.to_s
							@select_returns = ActiveRecord::Base.connection.select_all(@select_returns_sql.to_s)
							if(@select_returns.length == 0)
								@insert_sql = "Insert into rupeevest_returns(schemecode,return_year"+noy.to_s+")values("+@schemecode.to_s+","+@periodic_return.to_s+")"
								puts @insert_sql.to_s
								@insert_data = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
							else
								@update_sql = "update rupeevest_returns set return_year"+noy.to_s+" = "+@periodic_return.to_s+" where schemecode = "+@schemecode.to_s
								puts @update_sql.to_s
								@update_data = ActiveRecord::Base.connection.update(@update_sql.to_s)
							end
						end
					end
				 end
			end
		rescue=> err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def annual_returns_10months

		begin
			@select_schemes_sql = "Select schemecode from scheme_classifications "
			@select_schemes = ActiveRecord::Base.connection.select_all(@select_schemes_sql)
			@select_schemes.each do |ss|
				@schemecode = ss['schemecode'].to_i
				(1..10).each do |nom|
				puts nom.to_i
				@get_month_dates_sql = "SELECT DATE_SUB(LAST_DAY(DATE_ADD(NOW(), INTERVAL -"+nom.to_s+" MONTH)), INTERVAL DAY( LAST_DAY(DATE_ADD(NOW(), INTERVAL -"+nom.to_s+" MONTH)))-1 DAY) AS startdate,LAST_DAY(DATE_ADD(NOW(), INTERVAL -"+nom.to_s+" MONTH))AS enddate"
				@get_month_dates = ActiveRecord::Base.connection.select_all(@get_month_dates_sql.to_s)
				@get_month_dates.each do |gmd|
					@startdate = gmd['startdate'].to_s
					@enddate = gmd['enddate'].to_s
					puts @startdate.to_s
					puts @enddate.to_s
				end

					@nav_sql = "SELECT sc.schemecode, min( date_format(nh.navdate,'%Y-%m-%d') ) AS mindate,max( date_format(nh.navdate,'%Y-%m-%d') ) maxdate FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode WHERE date_format(nh.navdate,'%Y-%m-%d') between date_format('"+@startdate.to_s+"','%Y-%m-%d') and date_format('"+@enddate.to_s+"','%Y-%m-%d')and nh.schemecode = "+@schemecode.to_s
					puts @nav_sql.to_s
					@select_navdata = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)
					@select_navdata.each do |nd|
						@firstday_navrs = 0
						@lastday_navrs = 0
						@nav_mindate = nd['mindate'].to_s
						@nav_maxdate = nd['maxdate'].to_s
						@navdata_sql = "SELECT * FROM `navhistfull_adjnavs` WHERE (date_format(navdate,'%Y-%m-%d') = date_format('"+@nav_mindate.to_s+"','%Y-%m-%d') or date_format(navdate,'%Y-%m-%d') = date_format('"+@nav_maxdate.to_s+"','%Y-%m-%d')) and schemecode = "+@schemecode.to_s+" order by navdate asc"
						@select_monthsdata = ActiveRecord::Base.connection.select_all(@navdata_sql.to_s)
						@i = 0
						if (@select_monthsdata.length > 0 )
							@select_monthsdata.each do |sm|
							puts @i
								if(@i == 0)
									@firstday_navrs = sm['adjnavrs'].to_f
									@i = @i + 1
								else
									@lastday_navrs = sm['adjnavrs'].to_f
									@i = 0
								end
							end

							@periodic_return = (@lastday_navrs - @firstday_navrs)/@firstday_navrs * 100
							puts @periodic_return
							@select_returns_sql = "Select * from rupeevest_returns where schemecode = "+@schemecode.to_s
							@select_returns = ActiveRecord::Base.connection.select_all(@select_returns_sql.to_s)
							if(@select_returns.length == 0)
								@insert_sql = "Insert into rupeevest_returns(schemecode,return_month"+nom.to_s+")values("+@schemecode.to_s+","+@periodic_return.to_s+")"
								puts @insert_sql.to_s
								@insert_data = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
							else
								@update_sql = "update rupeevest_returns set return_month"+nom.to_s+" = "+@periodic_return.to_s+" where schemecode = "+@schemecode.to_s
								puts @update_sql.to_s
								@update_data = ActiveRecord::Base.connection.update(@update_sql.to_s)
							end
						end
					end
				 end
			end
		rescue=> err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def annual_returns_10quarters

		begin
			@select_schemes_sql = "Select schemecode from scheme_classifications"
			@select_schemes = ActiveRecord::Base.connection.select_all(@select_schemes_sql)
			@select_schemes.each do |ss|
				@schemecode = ss['schemecode'].to_i
				(1..10).each do |noq|
				puts noq.to_i
				noq_1 = noq + 1
				@get_quarter_dates_sql = "SELECT (MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())-"+noq_1.to_s+" QUARTER) as startdate,(MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())-"+noq.to_s+" QUARTER - INTERVAL 1 DAY) as enddate"
				@get_qrtr_dates = ActiveRecord::Base.connection.select_all(@get_quarter_dates_sql.to_s)
				@get_qrtr_dates.each do |gqd|
					@startdate = gqd['startdate'].to_s
					@enddate = gqd['enddate'].to_s
					puts @startdate.to_s
					puts @enddate.to_s
				end

					@nav_sql = "SELECT sc.schemecode, min( date_format(nh.navdate,'%Y-%m-%d') ) AS mindate,max( date_format(nh.navdate,'%Y-%m-%d') ) maxdate FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode WHERE date_format(nh.navdate,'%Y-%m-%d') between date_format('"+@startdate.to_s+"','%Y-%m-%d') and date_format('"+@enddate.to_s+"','%Y-%m-%d')and nh.schemecode = "+@schemecode.to_s
					puts @nav_sql.to_s
					@select_navdata = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)
					@select_navdata.each do |nd|
						@firstday_navrs = 0
						@lastday_navrs = 0
						@nav_mindate = nd['mindate'].to_s
						@nav_maxdate = nd['maxdate'].to_s
						@navdata_sql = "SELECT * FROM `navhistfull_adjnavs` WHERE (date_format(navdate,'%Y-%m-%d') = date_format('"+@nav_mindate.to_s+"','%Y-%m-%d') or date_format(navdate,'%Y-%m-%d') = date_format('"+@nav_maxdate.to_s+"','%Y-%m-%d')) and schemecode = "+@schemecode.to_s+" order by navdate asc"
						@select_quartersdata = ActiveRecord::Base.connection.select_all(@navdata_sql.to_s)
						@i = 0
						if (@select_quartersdata.length > 0 )
							@select_quartersdata.each do |sq|
							puts @i
								if(@i == 0)
									@firstday_navrs = sq['adjnavrs'].to_f
									@i = @i + 1
								else
									@lastday_navrs = sq['adjnavrs'].to_f
									@i = 0
								end
							end

							@periodic_return = (@lastday_navrs - @firstday_navrs)/@firstday_navrs * 100
							puts @periodic_return
							@select_returns_sql = "Select * from rupeevest_returns where schemecode = "+@schemecode.to_s
							@select_returns = ActiveRecord::Base.connection.select_all(@select_returns_sql.to_s)
							if(@select_returns.length == 0)
								@insert_sql = "Insert into rupeevest_returns(schemecode,return_quarter"+noq.to_s+")values("+@schemecode.to_s+","+@periodic_return.to_s+")"
								puts @insert_sql.to_s
								@insert_data = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
							else
								@update_sql = "update rupeevest_returns set return_quarter"+noq.to_s+" = "+@periodic_return.to_s+" where schemecode = "+@schemecode.to_s
								puts @update_sql.to_s
								@update_data = ActiveRecord::Base.connection.update(@update_sql.to_s)
							end
						end
					end
				 end
			end
		rescue=> err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def ytd_returns(ytd_class,ytd_classid)
		begin
		@classification_id = ytd_classid
		@classification	= ytd_class
		# Getting the number of funds for YTD based on classification

		#@sql = "SELECT sc.schemecode, sc.s_name, nh.navdate, nh.adjnavrs FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT(nh.navdate, '%Y-%m-%d') = DATE_FORMAT('2015-12-31','%Y-%m-%d')"

		@sql = "SELECT sc.schemecode, sc.s_name, nh.navdate, nh.adjnavrs FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT(nh.navdate, '%Y-%m-%d') = DATE_FORMAT((SELECT SUBDATE(MAKEDATE(YEAR(CURDATE()), 1), INTERVAL 1 DAY)),'%Y-%m-%d')"

		@num_of_funds = ActiveRecord::Base.connection.select_all(@sql.to_s)
		if @num_of_funds.length > 0
			@num_funds_ytd = @num_of_funds.length.to_i
			puts @num_funds_ytd

			# Getting Rank and YTD values for schemes based on classification

			#@ytd_data_qry = "SELECT sc.schemecode , sc.s_name , cn.navdate , nh.adjnavrs,cn.navrs as currentnav,(((cn.navrs -nh.adjnavrs)/nh.adjnavrs)*100) as ytd FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode join currentnavs cn on sc.schemecode = cn.schemecode  WHERE sc.classification =  '"+ @classification +"' AND DATE_FORMAT( nh.navdate, '%Y-%m-%d' ) = DATE_FORMAT('2015-12-31','%Y-%m-%d') and DATE_FORMAT( cn.navdate, '%Y-%m-%d' ) = DATE_FORMAT('2016-04-18', '%Y-%m-%d') order by ytd desc"

			@ytd_data_qry = "SELECT sc.schemecode , sc.s_name , cn.navdate , nh.adjnavrs,cn.navrs as currentnav,(((cn.navrs -nh.adjnavrs)/nh.adjnavrs)*100) as ytd FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode join currentnavs cn on sc.schemecode = cn.schemecode  WHERE sc.classification =  '"+ @classification +"' AND DATE_FORMAT( nh.navdate, '%Y-%m-%d' ) = DATE_FORMAT((SELECT SUBDATE(MAKEDATE(YEAR(CURDATE()), 1), INTERVAL 1 DAY)),'%Y-%m-%d') and DATE_FORMAT( cn.navdate, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(navdate,'%Y-%m-%d')) as navdate from currentnavs), '%Y-%m-%d') order by ytd desc"

			@ytd_data = ActiveRecord::Base.connection.select_all (@ytd_data_qry)
			@ytd_rank = 0
			@ytd_data.each do |yd|
				puts "inside do ytd data"
				@schemecode = yd['schemecode']
				@ytd = yd['ytd']
				@ytd_rank = @ytd_rank + 1
				puts @schemecode.to_i
				puts @ytd_rank
				@select_query = "Select * from scheme_rupeevests where schemecode = "+@schemecode.to_s
				puts @select_query
				@schemecode_search = ActiveRecord::Base.connection.select_all(@select_query)
				if(@schemecode_search.length > 0)
					puts "inside if ytd data"
					@update_query = "update scheme_rupeevests set rank_ytd = " +@ytd_rank.to_s + ", ytd_returns = "+@ytd.to_s + " where schemecode = "+ @schemecode.to_s
					puts @update_query.to_s
					@update_schemerupeevest = ActiveRecord::Base.connection.update(@update_query.to_s)
				else
					@insert_query = "insert into scheme_rupeevests (schemecode,rank_ytd,ytd_returns) values ("+@schemecode.to_s+","+@ytd_rank.to_s+","+@ytd.to_s+")"
					@insert_schemerupeevest = ActiveRecord::Base.connection.insert(@insert_query.to_s)
				end
			end
				# Getting YTD Average based on classification

			#@ytd_average = ActiveRecord::Base.connection.select_all ("Select sum(ytd)/count(*) as ytd_average from (SELECT sc.schemecode , sc.s_name , cn.navdate , nh.adjnavrs,cn.navrs as currentnav,(((cn.navrs -nh.navrs)/nh.adjnavrs)*100) as ytd FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode join currentnavs cn on sc.schemecode = cn.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( nh.navdate, '%Y-%m-%d' ) = DATE_FORMAT('2015-12-31','%Y-%m-%d') and DATE_FORMAT( cn.navdate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) order by ytd desc) as temp")

			@ytd_average = ActiveRecord::Base.connection.select_all ("Select sum(ytd)/count(*) as ytd_average from (SELECT sc.schemecode , sc.s_name , cn.navdate , nh.adjnavrs,cn.navrs as currentnav,(((cn.navrs -nh.navrs)/nh.adjnavrs)*100) as ytd FROM scheme_classifications sc JOIN navhistfull_adjnavs nh ON sc.schemecode = nh.schemecode join currentnavs cn on sc.schemecode = cn.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( nh.navdate, '%Y-%m-%d' ) = DATE_FORMAT((SELECT SUBDATE(MAKEDATE(YEAR(CURDATE()), 1), INTERVAL 1 DAY)),'%Y-%m-%d') and DATE_FORMAT( cn.navdate, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(navdate,'%Y-%m-%d')) as navdate from currentnavs), '%Y-%m-%d') order by ytd desc) as temp")

			if @ytd_average.length > 0
				@ytd_average.each do |ya|
					@ytd_avg = ya['ytd_average']
					puts @ytd_avg.to_s
					@select_class_qry = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
					puts @select_class_qry.to_s
					@select_class = ActiveRecord::Base.connection.select_all(@select_class_qry)
					if(@select_class.length > 0)
						@update_class = "update rupeevest_categories set ytd_avg = " +@ytd_avg.to_s + ",funds_num_ytd = " + @num_funds_ytd.to_s + " where classification_id = "+@classification_id.to_s
						puts @update_class.to_s
						@update_record = ActiveRecord::Base.connection.update(@update_class)
					else
						@insert_class = "Insert into rupeevest_categories(classification_id,ytd_avg, funds_num_ytd)values("+@classification_id.to_s+","+@ytd_avg.to_s+","+@num_funds_ytd.to_s+")"
						puts @insert_class.to_s
						@update_record = ActiveRecord::Base.connection.insert(@insert_class)
					end
				end
			end
		end
		rescue => err
			puts err.message
			lc.writelog(err.message,'rupeevest_category_returns.log')
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def month1_returns(month1_class,month1_classid)
		begin
		@classification_id = month1_classid
		@classification	= month1_class
		# Getting Num of funds,Rank and Month_1 return values for schemes based on classification

		#@month1_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.monthret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d') AND mr.monthret_1 IS NOT NULL ORDER BY mr.monthret_1 DESC")

		@month1_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.monthret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( (select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d') AND mr.monthret_1 IS NOT NULL ORDER BY mr.monthret_1 DESC")

		@month1_rank = 0
		@num_funds_month1 = @month1_data.length.to_i
		@month1_data.each do |m1|
			puts "inside do month1"
			@m1_schemecode = m1['schemecode']
			@month1_ret = m1['monthret_1']
			@month1_rank = @month1_rank + 1
			puts @m1_schemecode.to_i
			puts @month1_rank
			@m1_select_query = "Select * from scheme_rupeevests where schemecode = "+@m1_schemecode.to_s
			puts @m1_select_query
			@m1_schemecode_search = ActiveRecord::Base.connection.select_all(@m1_select_query)
			if(@m1_schemecode_search.length > 0 and !(@month1_ret.blank?) )
				puts "inside if month1"
				puts @classification.to_s
				@m1_update_query = "update scheme_rupeevests set rank_1month = " +@month1_rank.to_s + ", returns_1month = "+@month1_ret.to_s+" where schemecode = "+ @m1_schemecode.to_s
				puts @m1_update_query.to_s
				@update_schemerupeevest = ActiveRecord::Base.connection.update(@m1_update_query.to_s)
			end
		end
			# Getting Month_1 Average based on classification
		#@month1_return_qry = "SELECT sum( monthret_1 ) / count( * ) AS avg_monthret_1 FROM (SELECT sc.schemecode , sc.s_name , mr.monthret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) AND mr.monthret_1 IS NOT NULL ORDER BY mr.monthret_1 DESC ) AS temp"

		@month1_return_qry = "SELECT sum( monthret_1 ) / count( * ) AS avg_monthret_1 FROM (SELECT sc.schemecode , sc.s_name , mr.monthret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) AND mr.monthret_1 IS NOT NULL ORDER BY mr.monthret_1 DESC ) AS temp"

		@month1_average = ActiveRecord::Base.connection.select_all (@month1_return_qry.to_s)
		puts @month1_return_qry
		@month1_average.each do |ma1|
			@month1_avg = ma1['avg_monthret_1']
			puts @month1_avg.to_s
			@ma1_select_class_qry = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			puts @ma1_select_class_qry.to_s
			@ma1_select_class = ActiveRecord::Base.connection.select_all(@ma1_select_class_qry)
			if @ma1_select_class.length > 0
				@ma1_update_class = "update rupeevest_categories set avg_month1 = " +@month1_avg.to_s + ",funds_num_month1 = " + @num_funds_month1.to_s + " where classification_id = "+@classification_id.to_s
				puts @ma1_update_class.to_s
				@update_record = ActiveRecord::Base.connection.update(@ma1_update_class)
			else
				@ma1_insert_class = "Insert into rupeevest_categories(classification_id, avg_month1, funds_num_month1)values("+@classification_id.to_s+","+@month1_avg.to_s+","+@num_funds_month1.to_s+")"
				puts @ma1_insert_class.to_s
				@update_record = ActiveRecord::Base.connection.insert(@ma1_insert_class)
			end
		end

		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def month3_returns(month3_class,month3_classid)

	begin
		@classification_id = month3_classid
		@classification	= month3_class
		# Getting Num of funds,Rank and Month_3 return values for schemes based on classification

		#@month3_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.monthret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) AND mr.monthret_3 IS NOT NULL ORDER BY mr.monthret_3 DESC")

		@month3_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.monthret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( (select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) AND mr.monthret_3 IS NOT NULL ORDER BY mr.monthret_3 DESC")

		@month3_rank = 0
		@num_funds_month3 = @month3_data.length.to_i
		@month3_data.each do |m3|
			puts "inside do month3"
			@m3_schemecode = m3['schemecode']
			@month3_ret = m3['monthret_3']
			@month3_rank = @month3_rank + 1
			puts @m3_schemecode.to_i
			puts @month3_rank
			@m3_select_query = "Select * from scheme_rupeevests where schemecode = "+@m3_schemecode.to_s
			puts @m3_select_query
			@m3_schemecode_search = ActiveRecord::Base.connection.select_all(@m3_select_query)
			if(@m3_schemecode_search.length > 0 and !(@month3_ret.blank?) )
				puts "inside if month3"
				puts @classification.to_s
				@m3_update_query = "update scheme_rupeevests set rank_3month = " +@month3_rank.to_s + ", returns_3month = "+@month3_ret.to_s+" where schemecode = "+ @m3_schemecode.to_s
				puts @m3_update_query.to_s
				@update_schemerupeevest = ActiveRecord::Base.connection.update(@m3_update_query.to_s)
			end
		end
			# Getting Month_3 Average based on classification
		#@month3_return_qry = "SELECT sum( monthret_3 ) / count( * ) AS avg_monthret_3 FROM (SELECT sc.schemecode , sc.s_name , mr.monthret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) ORDER BY mr.monthret_3 DESC ) AS temp"

		@month3_return_qry = "SELECT sum( monthret_3 ) / count( * ) AS avg_monthret_3 FROM (SELECT sc.schemecode , sc.s_name , mr.monthret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) ORDER BY mr.monthret_3 DESC ) AS temp"

		@month3_average = ActiveRecord::Base.connection.select_all (@month3_return_qry.to_s)
		puts @month3_return_qry
		@month3_average.each do |ma3|
			@month3_avg = ma3['avg_monthret_3']
			puts @month3_avg.to_s
			@ma3_select_class_qry = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			puts @ma3_select_class_qry.to_s
			@ma3_select_class = ActiveRecord::Base.connection.select_all(@ma3_select_class_qry)
			if(@ma3_select_class.length > 0)
				@ma3_update_class = "update rupeevest_categories set avg_month3 = " +@month3_avg.to_s + ",funds_num_month3 = " + @num_funds_month3.to_s + " where classification_id = "+@classification_id.to_s
				puts @ma3_update_class.to_s
				@update_record = ActiveRecord::Base.connection.update(@ma3_update_class)
			else
				@ma3_insert_class = "Insert into rupeevest_categories(classification_id, avg_month3, funds_num_month3)values("+@classification_id.to_s+","+@month3_avg.to_s+","+@num_funds_month3.to_s+")"
				puts @ma3_insert_class.to_s
				@update_record = ActiveRecord::Base.connection.insert(@ma3_insert_class)
			end
		end
	rescue=> err
		puts err.message
	ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
	end
	end

	def year1_returns(year1_class,year1_classid)

		begin
			@classification_id = year1_classid
			@classification	= year1_class

			# Getting Num of funds,Rank and Year_1 return values for schemes based on classification

			#@year1_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.yrret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) AND mr.yrret_1 IS NOT NULL ORDER BY mr.yrret_1 DESC")

			@year1_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.yrret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( (select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) AND mr.yrret_1 IS NOT NULL ORDER BY mr.yrret_1 DESC")

			@year1_rank = 0
			@num_funds_year1 = @year1_data.length.to_i
			@year1_data.each do |y1|
				puts "inside do year1"
				@y1_schemecode = y1['schemecode']
				@year1_ret = y1['yrret_1']
				@year1_rank = @year1_rank + 1
				puts @y1_schemecode.to_i
				puts @year1_rank
				@y1_select_query = "Select * from scheme_rupeevests where schemecode = "+@y1_schemecode.to_s
				puts @y1_select_query
				@y1_schemecode_search = ActiveRecord::Base.connection.select_all(@y1_select_query)
				if(@y1_schemecode_search.length > 0 and !(@year1_ret.blank?) )
					puts "inside if year1"
					puts @classification.to_s
					@y1_update_query = "update scheme_rupeevests set rank_1year = " +@year1_rank.to_s + ", returns_1year = "+@year1_ret.to_s+" where schemecode = "+ @y1_schemecode.to_s
					puts @y1_update_query.to_s
					@update_schemerupeevest = ActiveRecord::Base.connection.update(@y1_update_query.to_s)
				end
			end
				# Getting Year_1 Average based on classification
			#@yearret1_return_qry = "SELECT sum( yrret_1 ) / count( * ) AS avg_yearret_1 FROM (SELECT sc.schemecode , sc.s_name , mr.yrret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) ORDER BY mr.yrret_1 DESC ) AS temp"

			@yearret1_return_qry = "SELECT sum( yrret_1 ) / count( * ) AS avg_yearret_1 FROM (SELECT sc.schemecode , sc.s_name , mr.yrret_1 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) ORDER BY mr.yrret_1 DESC ) AS temp"

			@year1_average = ActiveRecord::Base.connection.select_all (@yearret1_return_qry.to_s)
			puts @year1_return_qry
			@year1_average.each do |ya1|
				@year1_avg = ya1['avg_yearret_1']
				puts @year1_avg.to_s
				@ya1_select_class_qry = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
				puts @ya1_select_class_qry.to_s
				@ya1_select_class = ActiveRecord::Base.connection.select_all(@ya1_select_class_qry)
				if(@ya1_select_class.length > 0)
					@ya1_update_class = "update rupeevest_categories set avg_year1 = " +@year1_avg.to_s + ",funds_num_year1 = " + @num_funds_year1.to_s + " where classification_id = "+@classification_id.to_s
					puts @ya1_update_class.to_s
					@update_record = ActiveRecord::Base.connection.update(@ya1_update_class)
				else
					@ya1_insert_class = "Insert into rupeevest_categories(classification_id, avg_year1, funds_num_year1)values("+@classification_id.to_s+","+@year1_avg.to_s+","+@num_funds_year1.to_s+")"
					puts @ya1_insert_class.to_s
					@update_record = ActiveRecord::Base.connection.insert(@ya1_insert_class)
				end
			end
		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end

	end

	def year3_returns(year3_class,year3_classid)

		begin

			@classification_id = year3_classid
			@classification	= year3_class

			# Getting Num of funds,Rank and Year_3 return values for schemes based on classification

			#@year3_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.yearret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) AND mr.yearret_3 IS NOT NULL ORDER BY mr.yearret_3 DESC")

			@year3_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.yearret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( (select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) AND mr.yearret_3 IS NOT NULL ORDER BY mr.yearret_3 DESC")

			@year3_rank = 0
			@num_funds_year3 = @year3_data.length.to_i
			@year3_data.each do |y3|
				puts "inside do year3"
				@y3_schemecode = y3['schemecode']
				@year3_ret = y3['yearret_3']
				@year3_rank = @year3_rank + 1
				puts @y3_schemecode.to_i
				puts @year3_rank
				@y3_select_query = "Select * from scheme_rupeevests where schemecode = "+@y3_schemecode.to_s
				puts @y3_select_query
				@y3_schemecode_search = ActiveRecord::Base.connection.select_all(@y3_select_query)
				if(@y3_schemecode_search.length > 0 and !(@year3_ret.blank?) )
					puts "inside if year3"
					puts @classification.to_s
					@y3_update_query = "update scheme_rupeevests set rank_3year = " +@year3_rank.to_s + ", returns_3year = "+@year3_ret.to_s+" where schemecode = "+ @y3_schemecode.to_s
					puts @y3_update_query.to_s
					@update_schemerupeevest = ActiveRecord::Base.connection.update(@y3_update_query.to_s)
				end
			end
				# Getting Year_3 Average based on classification
			#@yearret3_return_qry = "SELECT sum( yearret_3 ) / count( * ) AS avg_yearret_3 FROM (SELECT sc.schemecode , sc.s_name , mr.yearret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) ORDER BY mr.yearret_3 DESC ) AS temp"

			@yearret3_return_qry = "SELECT sum( yearret_3 ) / count( * ) AS avg_yearret_3 FROM (SELECT sc.schemecode , sc.s_name , mr.yearret_3 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) ORDER BY mr.yearret_3 DESC ) AS temp"

			@year3_average = ActiveRecord::Base.connection.select_all (@yearret3_return_qry.to_s)
			puts @year3_return_qry
			@year3_average.each do |ya3|
				@year3_avg = ya3['avg_yearret_3']
				puts @year3_avg.to_s
				@ya3_select_class_qry = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
				puts @ya3_select_class_qry.to_s
				@ya3_select_class = ActiveRecord::Base.connection.select_all(@ya3_select_class_qry)
				if(@ya3_select_class.length > 0)
					@ya3_update_class = "update rupeevest_categories set avg_year3 = " +@year3_avg.to_s + ",funds_num_year3 = " + @num_funds_year3.to_s + " where classification_id = "+@classification_id.to_s
					puts @ya3_update_class.to_s
					@update_record = ActiveRecord::Base.connection.update(@ya3_update_class)
				else
					@ya3_insert_class = "Insert into rupeevest_categories(classification_id, avg_year3, funds_num_year3)values("+@classification_id.to_s+","+@year3_avg.to_s+","+@num_funds_year3.to_s+")"
					puts @ya3_insert_class.to_s
					@update_record = ActiveRecord::Base.connection.insert(@ya3_insert_class)
				end
			end
		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def year5_returns(year5_class,year5_classid)

		begin
			@classification_id = year5_classid
			@classification	= year5_class
			# Getting Num of funds,Rank and Year_5 return values for schemes based on classification

		#@year5_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.yearret_5 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) AND mr.yearret_5 IS NOT NULL ORDER BY mr.yearret_5 DESC")

		@year5_data = ActiveRecord::Base.connection.select_all ("SELECT sc.schemecode , sc.s_name , mr.yearret_5 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( (select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) AND mr.yearret_5 IS NOT NULL ORDER BY mr.yearret_5 DESC")

		@year5_rank = 0
		@num_funds_year5 = @year5_data.length.to_i
		@year5_data.each do |y5|
			puts "inside do year5"
			@y5_schemecode = y5['schemecode']
			@year5_ret = y5['yearret_5']
			@year5_rank = @year5_rank + 1
			puts @y5_schemecode.to_i
			puts @year5_rank
			@y5_select_query = "Select * from scheme_rupeevests where schemecode = "+@y5_schemecode.to_s
			puts @y5_select_query
			@y5_schemecode_search = ActiveRecord::Base.connection.select_all(@y5_select_query)
			if(@y5_schemecode_search.length > 0 and !(@year5_ret.blank?) )
				puts "inside if year5"
				puts @classification.to_s
				@y5_update_query = "update scheme_rupeevests set rank_5year = " +@year5_rank.to_s + ", returns_5year = "+@year5_ret.to_s+" where schemecode = "+ @y5_schemecode.to_s
				puts @y5_update_query.to_s
				@update_schemerupeevest = ActiveRecord::Base.connection.update(@y5_update_query.to_s)
			end
		end
			# Getting Year_5 Average based on classification
		#@yearret5_return_qry = "SELECT sum( yearret_5 ) / count( * ) AS avg_yearret_5 FROM (SELECT sc.schemecode , sc.s_name , mr.yearret_5 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT( '2016-04-18', '%Y-%m-%d' ) ORDER BY mr.yearret_5 DESC ) AS temp"

		@yearret5_return_qry = "SELECT sum( yearret_5 ) / count( * ) AS avg_yearret_5 FROM (SELECT sc.schemecode , sc.s_name , mr.yearret_5 FROM scheme_classifications sc JOIN mf_returns mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' AND DATE_FORMAT( mr.c_date, '%Y-%m-%d' ) = DATE_FORMAT((select max(date_format(c_date,'%Y-%m-%d')) as c_date from mf_returns), '%Y-%m-%d' ) ORDER BY mr.yearret_5 DESC ) AS temp"

		@year5_average = ActiveRecord::Base.connection.select_all (@yearret5_return_qry.to_s)
		puts @year5_return_qry
		@year5_average.each do |ya5|
			@year5_avg = ya5['avg_yearret_5']
			puts @year5_avg.to_s
			@ya5_select_class_qry = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			puts @ya5_select_class_qry.to_s
			@ya5_select_class = ActiveRecord::Base.connection.select_all(@ya5_select_class_qry)
			if(@ya5_select_class.length > 0)
				@ya5_update_class = "update rupeevest_categories set avg_year5 = " +@year5_avg.to_s + ",funds_num_year5 = " + @num_funds_year5.to_s + " where classification_id = "+@classification_id.to_s
				puts @ya5_update_class.to_s
				@update_record = ActiveRecord::Base.connection.update(@ya5_update_class)
			else
				@ya5_insert_class = "Insert into rupeevest_categories(classification_id, avg_year5, funds_num_year5)values("+@classification_id.to_s+","+@year5_avg.to_s+","+@num_funds_year5.to_s+")"
				puts @ya5_insert_class.to_s
				@update_record = ActiveRecord::Base.connection.insert(@ya5_insert_class)
			end
		end
		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end

	def std_devxy(std_classid,std_class)
		#Gets the values for num of funds, sdx_returns, sdy_returns and rank
		@classification_id = std_classid
		@classification	= std_class
		@num_of_funds_qry = "SELECT sc.schemecode,mr.sd_x,mr.sd_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.sd_x asc"

		@avg_sdx_qry = "Select (sum(sd_x)/count(*)) as avg_sd_x from (SELECT sc.schemecode, mr.sd_x, mr.sd_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' )  ORDER BY mr.sd_x asc ) as temp"

		@avg_sdx_data = ActiveRecord::Base.connection.select_all (@avg_sdx_qry)

		@num_of_funds_data = ActiveRecord::Base.connection.select_all(@num_of_funds_qry)
		@num_of_funds = @num_of_funds_data.length.to_i
		puts @num_of_funds.to_s
		if @num_of_funds > 0
			@rank_sd = 0
			puts @rank_sd
			@num_of_funds_data.each do |nfd|
			puts @rank_sd
				 @rank_sd = @rank_sd + 1
				 @sdx_schemecode = nfd['schemecode']
				 if !(nfd['sd_x'].blank?)
					@sdx_returns = nfd['sd_x'].to_s
					@sdy_returns = nfd['sd_y'].to_s

					 puts @sdx_returns.to_s
					 puts @sdy_returns.to_s
					 @select_scheme_sql = "Select * from scheme_rupeevests where schemecode = "+@sdx_schemecode.to_s
					 puts @select_scheme_sql
					 @select_scheme_data = ActiveRecord::Base.connection.select_all(@select_scheme_sql)
					 if @select_scheme_data.length > 0
						@update_scheme_qry = "update scheme_rupeevests set rank_sd = "+@rank_sd.to_s+",sdx_returns = "+@sdx_returns.to_s+",sdy_returns ="+@sdy_returns.to_s+" where schemecode = "+ @sdx_schemecode.to_s
						puts @update_scheme_qry
						update_scheme_rank = ActiveRecord::Base.connection.update(@update_scheme_qry)
					 else
						@insert_qry = "Insert into scheme_rupeevests(schemecode,rank_sd,sdx_retunrns,sdy_returns)values("+@sdx_schemecode.to_s+","+@rank_sd.to_s+","+@sdx_returns.to_s+","+@sdy_returns.to_s+")"
						insert_scheme_rank = ActiveRecord::Base.connection.insert(@insert_qry)
					 end
				end
			end

			# Gets the average for sdx
			puts "Mani"
			@avg_sdx_data.each do |sdx|
				@avg_sdx = sdx['avg_sd_x']
				end

			@select_class = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
			if @select_class_data.length > 0
				@update_qry = "update rupeevest_categories set no_of_funds_total = "+@num_of_funds.to_s+",avg_std_dev ="+@avg_sdx.to_s+" where classification_id = "+@classification_id.to_s
				puts @update_qry
				@update_record = ActiveRecord::Base.connection.update(@update_qry)
			else
				@insert_qry = "Insert into rupeevest_categories(classification_id, no_of_funds_total,avg_std_dev)values("+@classification_id.to_s+","+@num_of_funds.to_s+","+@avg_sdx_data.to_s+")"
				@update_record = ActiveRecord::Base.connection.insert(@insert_qry)
			end
		end
	end

	def sharpexy(scheme_classid,scheme_class)

	#Gets the values for num of funds, sdx_returns, sdy_returns and rank
		@classification_id = scheme_classid
		@classification = scheme_class
		@sharpe_funds_qry = "SELECT sc.schemecode,mr.sharpe_x,mr.sharpe_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.sharpe_x desc"

		@avg_sharpex_qry = "Select (sum(sharpe_x)/count(*)) as avg_sharpe_x from (SELECT sc.schemecode, mr.sharpe_x, mr.sharpe_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.sharpe_x desc) as temp"

		@avg_sharpex_data = ActiveRecord::Base.connection.select_all (@avg_sharpex_qry)

		@sharpe_funds_data = ActiveRecord::Base.connection.select_all(@sharpe_funds_qry)
		@sharpe_funds = @sharpe_funds_data.length.to_i
		puts @sharpe_funds.to_s
		if @sharpe_funds > 0
			@rank_sharpe = 0
			@sharpe_funds_data.each do |sf|
				 @rank_sharpe = @rank_sharpe + 1
				 @sf_schemecode = sf['schemecode']
				 if !(sf['sharpe_x'].blank?)
					@sfx_returns = sf['sharpe_x'].to_s
					@sfy_returns = sf['sharpe_y'].to_s

					 puts @sfx_returns.to_s
					 puts @sfy_returns.to_s
					 @select_scheme_sql = "Select * from scheme_rupeevests where schemecode = "+@sf_schemecode.to_s
					 puts @select_scheme_sql
					 @select_scheme_data = ActiveRecord::Base.connection.select_all(@select_scheme_sql)
					 if @select_scheme_data.length > 0
						@update_scheme_qry = "update scheme_rupeevests set rank_sharpe = "+@rank_sharpe.to_s+",sharpex_returns = "+@sfx_returns.to_s+",sharpey_returns ="+@sfy_returns.to_s+" where schemecode = "+ @sf_schemecode.to_s
						update_scheme_rank = ActiveRecord::Base.connection.update(@update_scheme_qry)
					 else
						@insert_qry = "Insert into scheme_rupeevests(schemecode,rank_sharpe,sharpex_retunrns,sharpey_returns)values("+@sf_schemecode.to_s+","+@rank_sharpe.to_s+","+@sfx_returns.to_s+","+@sfy_returns.to_s+")"
						insert_scheme_rank = ActiveRecord::Base.connection.insert(@insert_qry)
					 end
				end
			end

			puts "Mani"
			# Gets the average for sharpex

			@avg_sharpex_data.each do |shp|
				@avg_sharpe = shp['avg_sharpe_x']
				end

			@select_class = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
			if @select_class_data.length > 0
				@update_qry = "update rupeevest_categories set no_of_funds_total = "+@sharpe_funds.to_s+",avg_sharpe ="+@avg_sharpe.to_s+" where classification_id = "+@classification_id.to_s
				puts @update_qry
				@update_record = ActiveRecord::Base.connection.update(@update_qry)
			else
				@insert_qry = "Insert into rupeevest_categories(classification_id, no_of_funds_total,avg_sharpe)values("+@classification_id.to_s+","+@sharpe_funds.to_s+","+@avg_sharpe.to_s+")"
				@update_record = ActiveRecord::Base.connection.insert(@insert_qry)
			end
		end
	end

	def sotinoxy(scheme_classid,scheme_class)

	#Gets the values for num of funds, sdx_returns, sdy_returns and rank
		@classification_id = scheme_classid
		@classification = scheme_class

		@sotino_funds_qry = "SELECT sc.schemecode,mr.sortino_x,mr.sortino_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.sortino_x desc"
		puts @sotino_funds_qry.to_s
		@avg_st_qry = "Select (sum(sortino_x)/count(*)) as avg_sotino_x from (SELECT sc.schemecode, mr.sortino_x, mr.sortino_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.sortino_x desc) as temp"

		@avg_sotinox_data = ActiveRecord::Base.connection.select_all (@avg_st_qry)

		@sotino_funds_data = ActiveRecord::Base.connection.select_all(@sotino_funds_qry)
		@sotino_funds = @sotino_funds_data.length.to_i
		puts @sotino_funds.to_s
		if @sotino_funds > 0
			@rank_sotino = 0
			@sotino_funds_data.each do |st|
				 @rank_sotino = @rank_sotino + 1
				 @st_schemecode = st['schemecode']
				 if !(st['sortino_x'].blank?)
					@stx_returns = st['sortino_x'].to_s
					@sty_returns = st['sortino_y'].to_s

					 puts @stx_returns.to_s
					 puts @sty_returns.to_s
					 @select_scheme_sql = "Select * from scheme_rupeevests where schemecode = "+@st_schemecode.to_s
					 puts @select_scheme_sql
					 @select_scheme_data = ActiveRecord::Base.connection.select_all(@select_scheme_sql)
					 if @select_scheme_data.length > 0
						@update_scheme_qry = "update scheme_rupeevests set rank_sotino = "+@rank_sotino.to_s+",sotinox_returns = "+@stx_returns.to_s+",sotinoy_returns ="+@sty_returns.to_s+" where schemecode = "+ @st_schemecode.to_s
						puts @update_scheme_qry.to_s
						update_scheme_rank = ActiveRecord::Base.connection.update(@update_scheme_qry)
					 else
						@insert_qry = "Insert into scheme_rupeevests(schemecode,rank_sotino,sotinox_returns,sotinoy_returns)values("+@st_schemecode.to_s+","+@rank_sotino.to_s+","+@stx_returns.to_s+","+@sty_returns.to_s+")"
						insert_scheme_rank = ActiveRecord::Base.connection.insert(@insert_qry)
					 end
				end
			end

			# Gets the average for sharpex

			@avg_sotinox_data.each do |stx|
				@avg_sotinox = stx['avg_sotino_x']
				end

			@select_class = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
			if @select_class_data.length > 0
				@update_qry = "update rupeevest_categories set no_of_funds_total = "+@sotino_funds.to_s+",avg_sotino ="+@avg_sotinox.to_s+" where classification_id = "+@classification_id.to_s
				puts @update_qry
				@update_record = ActiveRecord::Base.connection.update(@update_qry)
			else
				@insert_qry = "Insert into rupeevest_categories(classification_id, no_of_funds_total,avg_sotino)values("+@classification_id.to_s+","+@sotino_funds.to_s+","+@avg_sotinox.to_s+")"
				@update_record = ActiveRecord::Base.connection.insert(@insert_qry)
			end
		end
	end

	def betaxy(scheme_classid,scheme_class)

	#Gets the values for num of funds, sdx_returns, sdy_returns and rank
		@classification_id = scheme_classid
		@classification = scheme_class
		@beta_funds_qry = "SELECT sc.schemecode,mr.beta_x,mr.beta_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.beta_x asc"

		@avg_beta_qry = "Select (sum(beta_x)/count(*)) as avg_beta_x from (SELECT sc.schemecode, mr.beta_x, mr.beta_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.beta_x asc) as temp"

		@avg_beta_data = ActiveRecord::Base.connection.select_all (@avg_beta_qry)

		@beta_funds_data = ActiveRecord::Base.connection.select_all(@beta_funds_qry)
		@beta_funds = @beta_funds_data.length.to_i
		puts @beta_funds.to_s
		if @beta_funds > 0
			@rank_beta = 0
			@beta_funds_data.each do |bt|
				 @rank_beta = @rank_beta + 1
				 @bt_schemecode = bt['schemecode']
				 if !(bt['beta_x'].blank?)
					@bx_returns = bt['beta_x'].to_s
					@by_returns = bt['beta_y'].to_s

					 puts @bx_returns.to_s
					 puts @by_returns.to_s
					 @select_scheme_sql = "Select * from scheme_rupeevests where schemecode = "+@bt_schemecode.to_s
					 puts @select_scheme_sql
					 @select_scheme_data = ActiveRecord::Base.connection.select_all(@select_scheme_sql)
					 if @select_scheme_data.length > 0
						@update_scheme_qry = "update scheme_rupeevests set rank_beta = "+@rank_beta.to_s+",betax_returns = "+@bx_returns.to_s+",betay_returns ="+@by_returns.to_s+" where schemecode = "+ @bt_schemecode.to_s
						update_scheme_rank = ActiveRecord::Base.connection.update(@update_scheme_qry)
					 else
						@insert_qry = "Insert into scheme_rupeevests(schemecode,rank_sotino,betax_returns,betay_returns)values("+@bt_schemecode.to_s+","+@rank_beta.to_s+","+@bx_returns.to_s+","+@by_returns.to_s+")"
						insert_scheme_rank = ActiveRecord::Base.connection.insert(@insert_qry)
					 end
				end
			end

			# Gets the average for sharpex

			@avg_beta_data.each do |bt|
				@avg_betax = bt['avg_beta_x']
				end

			@select_class = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
			if @select_class_data.length > 0
				@update_qry = "update rupeevest_categories set no_of_funds_total = "+@beta_funds.to_s+",avg_beta ="+@avg_betax.to_s+" where classification_id = "+@classification_id.to_s
				puts @update_qry
				@update_record = ActiveRecord::Base.connection.update(@update_qry)
			else
				@insert_qry = "Insert into rupeevest_categories(classification_id, no_of_funds_total,avg_beta)values("+@classification_id.to_s+","+@beta_funds.to_s+","+@avg_betax.to_s+")"
				@update_record = ActiveRecord::Base.connection.insert(@insert_qry)
			end
		end
	end

	def alphaxy(scheme_classid,scheme_class)

	#Gets the values for num of funds, sdx_returns, sdy_returns and rank
		@classification_id = scheme_classid
		@classification = scheme_class
		@alpha_funds_qry = "SELECT sc.schemecode,mr.jalpha_x,mr.jalpha_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.jalpha_x asc"

		@avg_alpha_qry = "Select (sum(jalpha_x)/count(*)) as avg_alpha_x from (SELECT sc.schemecode, mr.jalpha_x, mr.jalpha_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' )  ORDER BY mr.jalpha_x asc) as temp"

		@avg_alpha_data = ActiveRecord::Base.connection.select_all (@avg_alpha_qry)

		@alpha_funds_data = ActiveRecord::Base.connection.select_all(@alpha_funds_qry)
		@alpha_funds = @alpha_funds_data.length.to_i
		puts @alpha_funds.to_s
		if @alpha_funds > 0
			@rank_alpha = 0
			@alpha_funds_data.each do |ap|
				 @rank_alpha = @rank_alpha + 1
				 @ap_schemecode = ap['schemecode']
				 if !(ap['jalpha_x'].blank?)
					@jax_returns = ap['jalpha_x'].to_s
					@jay_returns = ap['jalpha_y'].to_s

					 puts @jax_returns.to_s
					 puts @jay_returns.to_s
					 @select_scheme_sql = "Select * from scheme_rupeevests where schemecode = "+@ap_schemecode.to_s
					 puts @select_scheme_sql
					 @select_scheme_data = ActiveRecord::Base.connection.select_all(@select_scheme_sql)
					 if @select_scheme_data.length > 0
						@update_scheme_qry = "update scheme_rupeevests set rank_alpha = "+@rank_alpha.to_s+",alphax_returns = "+@jax_returns.to_s+",alphay_returns ="+@jay_returns.to_s+" where schemecode = "+ @ap_schemecode.to_s
						update_scheme_rank = ActiveRecord::Base.connection.update(@update_scheme_qry)
					 else
						@insert_qry = "Insert into scheme_rupeevests(schemecode,rank_alpha,alphax_returns,alphay_returns)values("+@ap_schemecode.to_s+","+@rank_alpha.to_s+","+@jax_returns.to_s+","+@jay_returns.to_s+")"
						insert_scheme_rank = ActiveRecord::Base.connection.insert(@insert_qry)
					 end
				end
			end

			# Gets the average for sharpex

			@avg_alpha_data.each do |ap|
				@avg_alphax = ap['avg_alpha_x']
				end

			@select_class = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
			if @select_class_data.length > 0
				@update_qry = "update rupeevest_categories set no_of_funds_total = "+@alpha_funds.to_s+",avg_alpha ="+@avg_alphax.to_s+" where classification_id = "+@classification_id.to_s
				puts @update_qry
				@update_record = ActiveRecord::Base.connection.update(@update_qry)
			else
				@insert_qry = "Insert into rupeevest_categories(classification_id, no_of_funds_total,avg_alpha)values("+@classification_id.to_s+","+@alpha_funds.to_s+","+@avg_alphax.to_s+")"
				@update_record = ActiveRecord::Base.connection.insert(@insert_qry)
			end
		end
	end

	def treynor_ratio_xy(scheme_classid,scheme_class)

	#Gets the values for num of funds, sdx_returns, sdy_returns and rank
		@classification_id = scheme_classid
		@classification = scheme_class
		@treynor_funds_qry = "SELECT sc.schemecode,mr.treynor_x,mr.treynor_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.treynor_x asc"

		@avg_treynor_qry = "Select (sum(treynor_x)/count(*)) as avg_treynor_x from (SELECT sc.schemecode, mr.treynor_x, mr.treynor_y FROM scheme_classifications sc JOIN mf_ratios mr ON sc.schemecode = mr.schemecode WHERE sc.classification = '"+ @classification +"' and DATE_FORMAT( mr.upddate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-01-21', '%Y-%m-%d' ) ORDER BY mr.treynor_x asc) as temp"

		@avg_treynor_data = ActiveRecord::Base.connection.select_all (@avg_treynor_qry)

		@treynor_funds_data = ActiveRecord::Base.connection.select_all(@treynor_funds_qry)
		@treynor_funds = @treynor_funds_data.length.to_i
		puts @treynor_funds.to_s
		if @treynor_funds > 0
			@rank_treynor = 0
			@treynor_funds_data.each do |tf|
				 @rank_treynor = @rank_treynor + 1
				 @tf_schemecode = tf['schemecode']
				 if !(tf['treynor_x'].blank?)
					@trx_returns = tf['treynor_x'].to_s
					@try_returns = tf['treynor_y'].to_s

					 puts @trx_returns.to_s
					 puts @try_returns.to_s
					 @select_scheme_sql = "Select * from scheme_rupeevests where schemecode = "+@tf_schemecode.to_s
					 puts @select_scheme_sql
					 @select_scheme_data = ActiveRecord::Base.connection.select_all(@select_scheme_sql)
					 if @select_scheme_data.length > 0
						@update_scheme_qry = "update scheme_rupeevests set rank_treynor = "+@rank_treynor.to_s+",treynorx_returns = "+@trx_returns.to_s+",treynory_returns ="+@try_returns.to_s+" where schemecode = "+ @tf_schemecode.to_s
						update_scheme_rank = ActiveRecord::Base.connection.update(@update_scheme_qry)
					 else
						@insert_qry = "Insert into scheme_rupeevests(schemecode,rank_alpha,alphax_returns,alphay_returns)values("+@ap_schemecode.to_s+","+@rank_alpha.to_s+","+@trx_returns.to_s+","+@try_returns.to_s+")"
						insert_scheme_rank = ActiveRecord::Base.connection.insert(@insert_qry)
					 end
				end
			end

			# Gets the average for sharpex

			@avg_treynor_data.each do |tf|
				@avg_treynorx = tf['avg_treynor_x']
				end

			@select_class = "Select * from rupeevest_categories where classification_id = "+@classification_id.to_s
			@select_class_data = ActiveRecord::Base.connection.select_all(@select_class)
			if @select_class_data.length > 0
				@update_qry = "update rupeevest_categories set no_of_funds_total = "+@treynor_funds.to_s+",avg_treyno ="+@avg_treynorx.to_s+" where classification_id = "+@classification_id.to_s
				puts @update_qry
				@update_record = ActiveRecord::Base.connection.update(@update_qry)
			else
				@insert_qry = "Insert into rupeevest_categories(classification_id, no_of_funds_total,avg_treynor)values("+@classification_id.to_s+","+@treynor_funds_data.to_s+","+@avg_treynorx.to_s+")"
				@update_record = ActiveRecord::Base.connection.insert(@insert_qry)
			end
		end
	end

	def navgraph
		begin
			@select_schemes = "Select schemecode from scheme_classifications order by schemecode ASC"
			@get_schemes = ActiveRecord::Base.connection.select_all(@select_schemes.to_s)
			@get_schemes.each do |gs|
				schemecode = gs['schemecode'].to_s
				puts schemecode
				puts "inside 1 year"
				@nav_sql = "SELECT schemecode, date_format(navdate,'%Y-%m-%d') navdate, adjnavrs FROM `navhistfull_adjnavs` WHERE `schemecode` = "+schemecode+" AND navdate BETWEEN now() - INTERVAL 1 year AND now() ORDER BY navdate ASC"
				puts @nav_sql.to_s
				@nav_data = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)

				adjnavrs_firstday = @nav_data.first['adjnavrs']
				@nav_data.each do |nd|
					adjnavrs = nd['adjnavrs']
					navdate = nd['navdate']
					insert_navdata(schemecode,navdate,adjnavrs,adjnavrs_firstday,'year1_yvalue')
				end

				puts "inside 3 year"
				@nav_sql = "SELECT schemecode, date_format(navdate,'%Y-%m-%d') navdate, adjnavrs FROM `navhistfull_adjnavs` WHERE `schemecode` = "+schemecode+" AND navdate BETWEEN now() - INTERVAL 3 year AND now() ORDER BY navdate ASC"
				puts @nav_sql.to_s
				@nav_data = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)

				adjnavrs_firstday = @nav_data.first['adjnavrs']
				@nav_data.each do |nd|
					adjnavrs = nd['adjnavrs']
					navdate = nd['navdate']
					insert_navdata(schemecode,navdate,adjnavrs,adjnavrs_firstday,'year3_yvalue')
				end

				puts "inside 5 year"
				@nav_sql = "SELECT schemecode, date_format(navdate,'%Y-%m-%d') navdate, adjnavrs FROM `navhistfull_adjnavs` WHERE `schemecode` = "+schemecode+" AND navdate BETWEEN now() - INTERVAL 5 year AND now() ORDER BY navdate ASC"
				puts @nav_sql.to_s
				@nav_data = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)

				adjnavrs_firstday = @nav_data.first['adjnavrs']
				@nav_data.each do |nd|
					adjnavrs = nd['adjnavrs']
					navdate = nd['navdate']
					insert_navdata(schemecode,navdate,adjnavrs,adjnavrs_firstday,'year5_yvalue')
				end

				puts "inside 6 months"
				@nav_sql = "SELECT schemecode, date_format(navdate,'%Y-%m-%d') navdate, adjnavrs FROM `navhistfull_adjnavs` WHERE `schemecode` = "+schemecode+" AND navdate BETWEEN now() - INTERVAL 6 month AND now() ORDER BY navdate ASC"
				puts @nav_sql.to_s
				@nav_data = ActiveRecord::Base.connection.select_all(@nav_sql.to_s)

				adjnavrs_firstday = @nav_data.first['adjnavrs']
				@nav_data.each do |nd|
					adjnavrs = nd['adjnavrs']
					navdate = nd['navdate']
					insert_navdata(schemecode,navdate,adjnavrs,adjnavrs_firstday,'month6_yvalue')
				end
			end
		rescue=> err
			puts err.message
		end
	end
	def insert_navdata(schemecode,navdate,adjnavrs,adjnavrs_firstday,category)
		y_value = 100*( adjnavrs - adjnavrs_firstday)/adjnavrs_firstday
		puts y_value.to_s

		@select_nav = "select * from navgraphs where schemecode = "+schemecode+" AND date_format(navdate,'%Y-%m-%d') = date_format('"+navdate+"','%Y-%m-%d')"
		@select_navdata = ActiveRecord::Base.connection.select_all(@select_nav.to_s)
		if(@select_navdata.length > 0)
			puts "inside update"
			@update_sql = "Update navgraphs set "+category+" ="+y_value.to_s+" where schemecode = "+schemecode+" and date_format(navdate,'%Y-%m-%d') = date_format('"+navdate+"','%Y-%m-%d')"
			ActiveRecord::Base.connection.update(@update_sql.to_s)
		else
			puts "insid insert"
			@insert_sql = "Insert into navgraphs(schemecode,navdate,"+category+")values("+schemecode+",date_format('"+navdate+"','%Y-%m-%d'),"+y_value.to_s+")"
			ActiveRecord::Base.connection.insert(@insert_sql.to_s)
		end

	end

	def credit_rating_logic
		@classification_sql = "SELECT * FROM `scheme_classifications` WHERE `classification` like '%Debt%' or classification like '%Hybrid%'"
		@classification_data = ActiveRecord::Base.connection.select_all(@classification_sql.to_s)
		puts @classification_data.length
		@classification_data.each do |cd|
			classification = cd['classification'].to_s
			schemecode = cd['schemecode'].to_s
			puts schemecode
			@credit_rating_sql = "SELECT sc.schemecode,sc.classification,date_format(mf.invdate,'%Y-%m-%d') invdate ,sum(mf.`holdpercentage`) holdpercentage, cr.rupeevest_display_name FROM scheme_classifications sc join mf_portfolios mf on sc.schemecode = mf.schemecode JOIN credit_ratings cr ON mf.rating = cr.accord_display_name where sc.schemecode = "+schemecode+" and DATE_FORMAT( `invdate` , '%Y-%m-%d' ) = date_format((SELECT max(date_format(invdate, '%Y-%m-%d')) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') group by cr.rupeevest_display_name"
			@credit_rating_data = ActiveRecord::Base.connection.select_all(@credit_rating_sql.to_s)
			@credit_rating_data.each do |cr|
				invdate = cr['invdate'].to_s
				holdpercentage = cr['holdpercentage'].to_s
				disp_name = cr['rupeevest_display_name'].to_s
				puts invdate.to_s
				puts disp_name
				puts holdpercentage
				@select_sql = "Select * from credit_rating_sums where schemecode = "+schemecode+" and classification = '"+classification+"' and rupeevest_display_name = '"+disp_name+"'"
				@select_sql_data = ActiveRecord::Base.connection.select_all(@select_sql.to_s)
				if(@select_sql_data.length > 0)
					@delete_sql = "Delete from credit_rating_sums where schemecode = "+schemecode+" and classification = '"+classification+"' and rupeevest_display_name = '"+disp_name+"'"
					@delete_sql_data = ActiveRecord::Base.connection.delete(@delete_sql.to_s)
					#@update_sql = "Update credit_rating_sums set holdpercentage = "+holdpercentage+",  date_format(invdate,'%Y-%m-%d') = date_format('"+invdate+"','%Y-%m-%d') where schemecode = "+schemecode+" and classification = '"+classification+"' and rupeevest_display_name = '"+disp_name+"'"
					#@update_sql_data = ActiveRecord::Base.connection.update(@update_sql.to_s)
				end
					@insert_sql = "Insert into credit_rating_sums values ("+schemecode+",'"+classification+"',date_format('"+invdate+"','%Y-%m-%d'),"+holdpercentage+",'"+disp_name+"')"
					puts @insert_sql.to_s
					@insert_sql_data = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
				#end
			end
		end
	end

	def credit_rating_logic_group
		@classification_sql = "SELECT * FROM `scheme_classifications` WHERE `classification` like '%Debt%' or classification like '%Hybrid%'"
		@classification_data = ActiveRecord::Base.connection.select_all(@classification_sql.to_s)
		puts @classification_data.length
		@classification_data.each do |cd|
			classification = cd['classification'].to_s
			schemecode = cd['schemecode'].to_s
			puts schemecode
			@credit_rating_sql = "SELECT sc.schemecode,sc.classification,date_format(mf.invdate,'%Y-%m-%d') invdate ,sum(mf.`holdpercentage`) holdpercentage, cr.rupeevest_group FROM scheme_classifications sc join mf_portfolios mf on sc.schemecode = mf.schemecode JOIN credit_ratings cr ON mf.rating = cr.accord_display_name where sc.schemecode = "+schemecode+" and DATE_FORMAT( `invdate` , '%Y-%m-%d' ) = date_format((SELECT max(date_format(invdate, '%Y-%m-%d')) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') group by cr.rupeevest_group"
			@credit_rating_data = ActiveRecord::Base.connection.select_all(@credit_rating_sql.to_s)
			@credit_rating_data.each do |cr|
					invdate = cr['invdate'].to_s
				holdpercentage = cr['holdpercentage'].to_s
				disp_name = cr['rupeevest_group'].to_s
				puts invdate.to_s
				puts disp_name
				puts holdpercentage
				@select_sql = "Select * from credit_rating_sum_groups where schemecode = "+schemecode+" and classification = '"+classification+"' and rupeevest_group = '"+disp_name+"'"
				@select_sql_data = ActiveRecord::Base.connection.select_all(@select_sql.to_s)
				if(@select_sql_data.length > 0)
					@delete_sql = "Delete from credit_rating_sum_groups where schemecode = "+schemecode+" and classification = '"+classification+"' and rupeevest_group = '"+disp_name+"'"
					@delete_sql_data = ActiveRecord::Base.connection.delete(@delete_sql.to_s)
					#@update_sql = "Update credit_rating_sums set holdpercentage = "+holdpercentage+",  date_format(invdate,'%Y-%m-%d') = date_format('"+invdate+"','%Y-%m-%d') where schemecode = "+schemecode+" and classification = '"+classification+"' and rupeevest_display_name = '"+disp_name+"'"
					#@update_sql_data = ActiveRecord::Base.connection.update(@update_sql.to_s)
				end
					@insert_sql = "Insert into credit_rating_sum_groups values ("+schemecode+",'"+classification+"',date_format('"+invdate+"','%Y-%m-%d'),"+holdpercentage+",'"+disp_name+"')"
					puts @insert_sql.to_s
					@insert_sql_data = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
				#end
			end
		end
	end
end
