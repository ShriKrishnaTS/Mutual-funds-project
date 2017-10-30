class SectAllocationCatavgController < ApplicationController

	def sect_alloc_catavg
		begin
			@select_ma
			@select_class = "Select * from classification_masters order by classification_id asc"
			@class_data = ActiveRecord::Base.connection.select_all(@select_class)
			@class_data.each do |cd|
				@classification_id = cd['classification_id']
				@classification = cd['classification']
				@class_sql = "select count(*)as clscnt from scheme_classifications where classification = '"+@classification.to_s+"'"
				@class_sect_cnt = ActiveRecord::Base.connection.select_all(@class_sql)
				@class_sect_cnt.each do |cs|
					@class_count = cs['clscnt']
				end
				puts @class_count.to_s
				@sect_sql = "select sc.schemecode,sa.sect_code,sa.sect_name,sum(sa.perc_hold) as perc_hold from scheme_classifications sc join sect_allocations sa on sc.schemecode = sa.schemecode where sc.classification = '"+@classification.to_s+"' and date_format(sa.`invdate`,'%Y-%m-%d') = date_format((select max(date_format(invdate,'%Y-%m-%d')) as invdate from sect_allocations),'%Y-%m-%d') group by sect_code order by sa.sect_code"
				@sect_avg = ActiveRecord::Base.connection.select_all(@sect_sql)
				@sect_avg.each do |sa|
					@sect_code = sa['sect_code']
					@perc_hold = sa['perc_hold']
					@avg_sect = @perc_hold / @class_count
					@select_sql = "Select * from sect_allocation_catavgs where classification_id = "+@classification_id.to_s+" and sect_code = "+@sect_code.to_s
					@select_data = ActiveRecord::Base.connection.select_all(@select_sql)
					if @select_data.length > 0
						@update_sql = "update sect_allocation_catavgs set sect_cat_avg = "+@avg_sect.to_s+" where classification_id = "+@classification_id.to_s+" and sect_code = "+@sect_code.to_s
						@update_data = ActiveRecord::Base.connection.update(@update_sql)
					else
						@insert_sql = "insert into sect_allocation_catavgs(classification_id,sect_code,sect_cat_avg) values("+@classification_id.to_s+","+@sect_code.to_s+","+@avg_sect.to_s+")"
						puts @insert_sql.to_s
						@insert_data = ActiveRecord::Base.connection.insert(@insert_sql)
					end
				
				end
			end
			
		rescue => err
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end
	end
	
	def rupeevest_sector_category_average
		
		begin
			@select_class = "Select * from classification_masters order by classification_id asc"
			@class_data = ActiveRecord::Base.connection.select_all(@select_class)
			@class_data.each do |cd|
				@classification_id = cd['classification_id']
				@classification = cd['classification']
				@class_sql = "select count(*)as clscnt from scheme_classifications where classification = '"+@classification.to_s+"'"
				@class_sect_cnt = ActiveRecord::Base.connection.select_all(@class_sql)
				@class_sect_cnt.each do |cs|
					@class_count = cs['clscnt']
					puts @class_count
					@sect_sql = "SELECT sum( mf.`holdpercentage` ) AS holdpercentage, rv.rv_sect_code, rv_sect_name FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rv ON ri.rv_sect_code = rv.rv_sect_code JOIN scheme_classifications sc ON mf.schemecode = sc.schemecode WHERE date_format( mf.`invdate` , '%Y-%m-%d' ) = date_format((SELECT max( date_format( invdate, '%Y-%m-%d' ) ) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') AND mf.asect_code =1 AND sc.classification = '"+@classification.to_s+"' GROUP BY rv.rv_sect_name"
					puts @sect_sql
					@sect_avg = ActiveRecord::Base.connection.select_all(@sect_sql)
					@sect_avg.each do |sa|
						@sect_code = sa['rv_sect_code']
						@perc_hold = sa['holdpercentage']
						puts @perc_hold.to_s
						puts @sect_code
						@avg_sect = @perc_hold / @class_count
						puts @avg_sect
						@select_sql = "Select * from rupeevest_sector_cat_avgs where classification_id = "+@classification_id.to_s+" and rv_sect_code = "+@sect_code.to_s
						@select_data = ActiveRecord::Base.connection.select_all(@select_sql)
						if @select_data.length > 0
							@update_sql = "update rupeevest_sector_cat_avgs set holdpercentage = "+@perc_hold.to_s+"  cat_avg = "+@avg_sect.to_s+" where classification_id = "+@classification_id.to_s+" and rv_sect_code = "+@sect_code.to_s
							@update_data = ActiveRecord::Base.connection.update(@update_sql)
						else
							@insert_sql = "insert into rupeevest_sector_cat_avgs(classification_id,rv_sect_code,holdpercentage,cat_avg) values("+@classification_id.to_s+","+@sect_code.to_s+","+@perc_hold.to_s+","+@avg_sect.to_s+")"
							puts @insert_sql.to_s
							@insert_data = ActiveRecord::Base.connection.insert(@insert_sql)
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
	
	def sector_holdperc
		begin
			@sql = "Select schemecode from scheme_classifications order by schemecode asc"
			@scheme_data = ActiveRecord::Base.connection.select_all(@sql)
			@scheme_data.each do |sd|
				@schemecode = sd['schemecode']
				puts @schemecode.to_s
				@sect_data_sql = "SELECT sum( mf.`holdpercentage` ) AS holdpercentage, rv.rv_sect_code FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rv ON ri.rv_sect_code = rv.rv_sect_code WHERE date_format( mf.`invdate` , '%Y-%m-%d' ) = date_format((SELECT max(date_format( invdate, '%Y-%m-%d' )) AS invdate FROM mf_portfolios ) , '%Y-%m-%d') AND mf.schemecode = "+@schemecode.to_s+" AND mf.asect_code = 1 GROUP BY rv.rv_sect_code"
				puts @sect_data_sql.to_s
				@sect_data = ActiveRecord::Base.connection.select_all(@sect_data_sql)
				@sect_data.each do |sc|
					@rv_sect_code = sc['rv_sect_code']
					@hold_perc = sc['holdpercentage']
					puts @rv_sect_code.to_s
					puts @hold_perc.to_s
					@sect_hp_sql = "select * from rupeevest_sect_holdpercs where schemecode = "+@schemecode.to_s+" and rv_sect_code = "+@rv_sect_code.to_s
					puts @sect_hp_sql
					@sect_hp_sql_data = ActiveRecord::Base.connection.select_all(@sect_hp_sql)
					if(@sect_hp_sql_data.length > 0)
						@update_sql = "update rupeevest_sect_holdpercs set hold_perc = "+@hold_perc.to_s+" where schemecode = "+@schemecode.to_s+" and rv_sect_code = "+@rv_sect_code.to_s
						puts @update_sql
						@update_data = ActiveRecord::Base.connection.update(@update_sql)
					else
						@insert_sql = "insert into rupeevest_sect_holdpercs(schemecode,rv_sect_code,hold_perc)values("+@schemecode.to_s+","+@rv_sect_code.to_s+","+@hold_perc.to_s+")"
						puts @insert_sql
						@insert_data = ActiveRecord::Base.connection.insert(@insert_sql)
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
	
	def sector_holdperc_quarterly
	
		begin
			@select_schemes_sql = "Select schemecode from scheme_classifications order by schemecode asc"
			@select_schemes = ActiveRecord::Base.connection.select_all(@select_schemes_sql)
			@select_schemes.each do |ss|
				@schemecode = ss['schemecode'].to_i
				(1..5).each do |noq|
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
				@get_max = "SELECT date_format(max(invdate),'%Y-%m-%d') as invdate FROM `mf_portfolios` WHERE (date_format(invdate,'%Y-%m-%d') between date_format('"+@startdate+"','%Y-%m-%d') and date_format('"+@enddate+"','%Y-%m-%d')) and schemecode = "+@schemecode.to_s
				puts @get_max
				@invdate=""
				@get_max_data = ActiveRecord::Base.connection.select_all(@get_max.to_s)
				if(@get_max_data.length > 0 )
					@get_max_data.each do|gd|
						@invdate = gd['invdate']
						puts @invdate
					end
					if(@invdate.blank?)
						puts "Empty"
					else
						@sect_data_sql = "SELECT mf.`holdpercentage`, rv.rv_sect_code FROM mf_portfolios mf JOIN mf_companymasters mc ON mf.fincode = mc.fincode JOIN rupeevest_sector_industries ri ON mc.ind_code = ri.ind_code JOIN rupeevest_sectors rv ON ri.rv_sect_code = rv.rv_sect_code WHERE date_format( mf.`invdate` , '%Y-%m-%d' ) = date_format('"+@invdate+"' , '%Y-%m-%d') AND mf.schemecode = "+@schemecode.to_s+" AND mf.asect_code = 1 GROUP BY rv.rv_sect_code"
						puts @sect_data_sql
						@sect_data = ActiveRecord::Base.connection.select_all(@sect_data_sql.to_s)
						if(@sect_data.length > 0)
							@sect_data.each do |sd|
								@hold_perc = sd['holdpercentage']
								@rv_sect_code = sd['rv_sect_code']
														
								@select_sect = "select * from rupeevest_sect_holdpercs where schemecode = "+@schemecode.to_s+" AND rv_sect_code = "+@rv_sect_code.to_s
								puts @select_sect
								puts @noq.to_s
								@select_sect_data = ActiveRecord::Base.connection.select_all(@select_sect.to_s)
								if (@select_sect_data.length>0)
									@update_sql = "update rupeevest_sect_holdpercs set hold_perc_q"+noq.to_s+" = "+@hold_perc.to_s+" where schemecode = "+@schemecode.to_s+" AND rv_sect_code = "+@rv_sect_code.to_s
									puts @update_sql
									@update_data = ActiveRecord::Base.connection.update(@update_sql)
								else
									@insert_sql = "insert into rupeevest_sect_holdpercs(schemecode,rv_sect_code,hold_perc_q"+noq.to_s+")values("+@schemecode.to_s+","+@rv_sect_code.to_s+","+@hold_perc.to_s+")"
									puts @insert_sql
									@insert_data = ActiveRecord::Base.connection.insert(@insert_sql)
								end
							end
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
end
