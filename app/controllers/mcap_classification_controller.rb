class McapClassificationController < ApplicationController

	def get_mcap_classification()
		@logfile = "mcap_classification"
		begin
			lc = LogcreatorController.new
			lc.createlogfile(@logfile)
			#@mcap_avg = ActiveRecord::Base.connection.select_all("SELECT `ps_code` , sum( mcap_company ) / count( * ) AS mcap_avg, count( * ) AS mcap_count	FROM `marketcaps` GROUP BY `ps_code` ORDER BY mcap_avg DESC ")
			mcap_avg_query = "SELECT ps_code ,sum( mcap_company ) / count( * ) AS mcap_avg, count( * ) AS mcap_count,s_name FROM(select mc.ps_code,mc.mcap_company,temp.s_name from marketcaps mc  join (SELECT * FROM mf_companymasters WHERE (scripcode != '' OR symbol != '') AND category != 'MF' AND ind_code != 147 AND status = 'Active') as temp on mc.ps_code = temp.fincode where mc.trade_date  between (CURRENT_DATE - INTERVAL 6 MONTH) and current_date) temp2 GROUP BY temp2.ps_code ORDER BY mcap_avg DESC"
			puts mcap_avg_query
			@mcap_avg = ActiveRecord::Base.connection.select_all(mcap_avg_query)
			
					ps_codes = ""
					mcap_avg_total=0
					k=0
					j=0
					l=0
					@mcap_avg.each do|i|
					k = k + 1
					 if i['mcap_avg'] != 0 && i['mcap_avg'] != nil
						mcap_avg_total = mcap_avg_total + i['mcap_avg']
						if j == 0 
							ps_codes = "(" + i['ps_code'].to_s
						else
							ps_codes = ps_codes + "," + i['ps_code'].to_s
						end
						j = j + 1
					 end
					end
					l = k - j
					ps_codes = ps_codes + ")"
					puts "Total No of Records is : "+k.to_s
					puts "No of Records which have some value is : "+j.to_s
					puts "No of Records which have Nil Value is : "+l.to_s
					puts "Total Mcap value : "+ mcap_avg_total.to_s
					
					lcapvalue = (mcap_avg_total * 70) / 100
					mcapvalue =  (mcap_avg_total * 20) / 100
					scapvalue = (mcap_avg_total * 10) / 100
					
					puts "Large Cap Value = " + lcapvalue.to_s
					puts "Middle Cap value = " + mcapvalue.to_s
					puts "Small Cap Value = " + scapvalue.to_s
					grandtotal = lcapvalue + mcapvalue + scapvalue
					puts "Grand Mcap Value : " + grandtotal.to_s
					lmsg = lcapvalue.to_s + "," + mcapvalue.to_s + "," + scapvalue.to_s + "," + grandtotal.to_s
					lc.writelog(lmsg,@logfile)
					lcap_total = 0
					mcap_total = 0
					scap_total = 0
					mtcap_total = 0
					lcap_pscodes = ""
					mcap_pscodes = ""
					scap_pscodes = ""
					mtcap_pscodes = ""
					puts "Hai"
					@ps_codes=""
					puts "hi"
					l = 0 
					m = 0 
					s = 0 
					@mcap_avg.each do|i|
					
					 if i['mcap_avg'] != 0 && i['mcap_avg'] != nil
					 
						if(l == 0)
							if lcap_total + i['mcap_avg'] <= lcapvalue 
								lcap_total = lcap_total + i['mcap_avg']
								#lcap_pscodes = lcap_pscodes + "," + i['ps_code'].to_s
								message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "L" + "," + lcap_total.to_s
								lc.writelog(message,@logfile)
								insert_mcap_classification(i['ps_code'],i['mcap_avg'],"L")
							else
								l = 1 
								mcap_total = mcap_total + i['mcap_avg']
								#mcap_pscodes = mcap_pscodes + "," + i['ps_code'].to_s
								message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "M" + "," + mcap_total.to_s
								lc.writelog(message,@logfile)
								insert_mcap_classification(i['ps_code'],i['mcap_avg'],"M")
							end
						elsif(m == 0)
							if mcap_total + i['mcap_avg'] <= mcapvalue
								mcap_total = mcap_total + i['mcap_avg']
								#mcap_pscodes = mcap_pscodes + "," + i['ps_code'].to_s
								message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "M" + "," + mcap_total.to_s
								lc.writelog(message,@logfile)
								insert_mcap_classification(i['ps_code'],i['mcap_avg'],"M")
							else
								m = 1 
								scap_total = scap_total + i['mcap_avg']
								#scap_pscodes = scap_pscodes + "," + i['ps_code'].to_s
								message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "S" + "," + scap_total.to_s
								lc.writelog(message,@logfile)
								insert_mcap_classification(i['ps_code'],i['mcap_avg'],"S")
							end
						else
							scap_total = scap_total + i['mcap_avg']
							#scap_pscodes = scap_pscodes + "," + i['ps_code'].to_s
							message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "S" + "," + scap_total.to_s
							lc.writelog(message,@logfile)
							insert_mcap_classification(i['ps_code'],i['mcap_avg'],"S")
		# Don't remove this commeted part below because it is a logic change. May be in future it will be used.					
							# if scap_total + i['mcap_avg'] <= scapvalue 
								# scap_total = scap_total + i['mcap_avg']
								# scap_pscodes = scap_pscodes + "," + i['ps_code'].to_s
								# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "S" + "," + scap_total.to_s
								# lc.writelog(message,@logfile)
								# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"S")
							# else
								# s = 1 
								# mtcap_pscodes = mtcap_pscodes + "," + i['ps_code'].to_s
								# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "O" 
								# lc.writelog(message,@logfile)
								# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"O")
							# end
						# else
							# mtcap_pscodes = mtcap_pscodes + "," + i['ps_code'].to_s
							# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "O" 
							# lc.writelog(message,@logfile)
							# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"O")
						end
					 
					 
						# if lcap_total + i['mcap_avg'] <= lcapvalue && l == 0 
							# lcap_total = lcap_total + i['mcap_avg']
							# #lcap_pscodes = lcap_pscodes + "," + i['ps_code'].to_s
							# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "L" + "," + lcap_total.to_s
							# lc.writelog(message,@logfile)
							# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"L")	
						# elsif mcap_total + i['mcap_avg'] <= mcapvalue && lcap_total + i['mcap_avg'] > lcapvalue && m == 0
							# l = 1 
							# mcap_total = mcap_total + i['mcap_avg']
							# #mcap_pscodes = mcap_pscodes + "," + i['ps_code'].to_s
							# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "M" + "," + mcap_total.to_s
							# lc.writelog(message,@logfile)
							# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"M")
						# elsif scap_total + i['mcap_avg'] <= scapvalue && lcap_total + i['mcap_avg'] > lcapvalue && mcap_total + i['mcap_avg'] > mcapvalue && s = 0 
							# m = 1 
							# scap_total = scap_total + i['mcap_avg']
							# #scap_pscodes = scap_pscodes + "," + i['ps_code'].to_s
							# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "S" + "," + scap_total.to_s
							# lc.writelog(message,@logfile)
							# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"S")
						# else
							# s = 1 
							# mtcap_pscodes = mtcap_pscodes + "," + i['ps_code'].to_s
							# message = i['ps_code'].to_s + "," + i['mcap_avg'].to_s + "," + "O" 
							# lc.writelog(message,@logfile)
							# insert_mcap_classification(i['ps_code'],i['mcap_avg'],"O")
						# end
					 end
					end
					
					
				# respond_to do |format|
				# format.json { 
					# render json: {:mcap_avg => @mcap_avg}
				# } 
				#end
		rescue => err
			#puts @ps_codes.to_s
			puts err.message
		ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
		end 

	end

	def insert_mcap_classification(ps_code,mcap_company,classification)

		begin
			  lc = LogcreatorController.new
			  lc.createlogfile(@logfile)
			  # mc = McapClassification.new
			  # mc.ps_code = ps_code
			  # mc.mcap_company = mcap_company
			  # mc.classification = classification
			  # mc.remarks1 = "-"
			  # mc.remarks2 = "-"
			  # mc.remarks3 = "-"
			  # mc.save
			  puts "inside insert function"
			  puts ps_code
		@select_sql = "select * from mcap_classifications where ps_code = "+ps_code.to_s
		puts @select_sql.to_s
		@select_pscode = ActiveRecord::Base.connection.select_all(@select_sql)
			puts @select_pscode.length
			if @select_pscode.length > 0
				puts "inside update block"
				@update_sql = "update mcap_classifications set mcap_company = "+mcap_company.to_s+", classification = '"+classification+"', remarks1 = '-', remarks2 = '-', remarks3 = '-' where ps_code = "+ps_code.to_s+"" 
				
				puts @update_sql.to_s
				update_pscode = ActiveRecord::Base.connection.update(@update_sql.to_s)
				puts "record updated"
			else
				puts "inside insert block"
				@insert_sql = "insert into mcap_classifications(ps_code, mcap_company, classification, remarks1, remarks2, remarks3) values ("+ps_code.to_s+","+mcap_company.to_s+",'"+classification+"','-','-','-')"
				
				puts @insert_sql.to_s
				insert_scheme = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
				puts "record inserted"
			end
		rescue => err
				puts err.message
				
		end

	end

def get_scheme_classification()
	@logfile = "scheme_classification"
	lc = LogcreatorController.new
    lc.createlogfile(@logfile)
	cf_schemecode=0
	cf_schemename=""
	s_name=""
	@lcap_value = 0
	@mcap_value = 0
	@scap_value = 0
	begin
	 # Straight forward one for Classifications
	 	 
	 @portfolio_largecap = ActiveRecord::Base.connection.select_all("select sum(mf.holdpercentage) as holdpercentage, sd.schemecode,sd.s_name,sd.classcode,sd.primary_fd_code,sd.status,temp1.invdate from mf_portfolios mf join scheme_details_fulls sd on sd.primary_fd_code = mf.schemecode join (select max(date_format(invdate,'%y-%m-%d')) as invdate, schemecode from mf_portfolios group by schemecode) temp1 on mf.schemecode=temp1.schemecode where sd.classcode in (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53) and date_format(mf.invdate, '%y-%m-%d') = date_format(temp1. invdate,'%y-%m-%d') and sd.schemecode in (select sd.schemecode from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in  (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and status = 'active' and opt_code = '1'  and sd.classcode in  (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53) and !(sd.ispurchaseavailable='n' and sd.type_code='1')  union  select sd.schemecode from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in  (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and sd.status = 'active' and sd.primary_fd_code not in (select sd.primary_fd_code from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in  (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and status = 'active' and opt_code = '1') and sd.classcode in  (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53) and !(sd.ispurchaseavailable='n' and sd.type_code='1') group by sd.primary_fd_code) group by sd.schemecode order by holdpercentage desc")
	 
	 #@portfolio_largecap = ActiveRecord::Base.connection.select_all("SELECT sum(mf.holdpercentage) AS holdpercentage, mf.schemecode,sd.s_name,sd.classcode,sd.primary_fd_code FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.classcode IN (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53) AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') GROUP BY mf.schemecode ORDER BY holdpercentage DESC")
	 
	#@portfolio_largecap = ActiveRecord::Base.connection.select_all("SELECT sum(mf.holdpercentage) AS holdpercentage, mf.schemecode,sd.s_name,sd.classcode,sd.primary_fd_code FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.classcode IN (2,3,4,5,6,9,10,39,42,20,21,50,51,52,40,56,38,41,25,8,26,43,19,44,47,12,13,14,15,54,57,11,48,53) AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d') GROUP BY mf.schemecode ORDER BY holdpercentage DESC")
	
	@portfolio_largecap.each do |cf|
		cf_schemecode = cf['schemecode']
		cf_fdcode = cf['primary_fd_code']
		puts cf_schemecode
		cf_schemename = cf['s_name']
		if(cf_schemecode == 12413 or cf_schemecode == 9247 or cf_schemecode == 14632)
			insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Others",0,0,0,0,cf_fdcode)
		elsif(cf_schemecode == 17463)
			insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Index",0,0,0,0,cf_fdcode)
		elsif(cf_schemecode == 17643 or cf_schemecode == 13397 )
				insert_scheme_classification(cf_schemecode,s_name,"ETF : Index",0,0,0,0,cf_fdcode)
		else
			if cf['classcode'] != 0  && cf['classcode'] != nil
				#if cf['classcode'] == 7 or cf['classcode'] == 34
					#insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Large Cap",0,0,0,0)
				if cf['classcode'] == 2
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Auto",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 3
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Financial Services",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 4
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Media",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 5
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Energy/Power",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 6
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Tech",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 9
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-FMCG",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 10
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Pharma",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 39
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Service Industries",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 42
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Sector-Infrastructure",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 20 or cf['classcode'] == 21 or cf['classcode'] == 50 or cf['classcode'] == 51 or cf['classcode'] == 52
					insert_scheme_classification(cf_schemecode,cf_schemename,"Debt : FTP/FMP",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 40 or cf['classcode'] == 56
					insert_scheme_classification(cf_schemecode,cf_schemename,"Debt : Others",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 38 or cf['classcode'] == 41
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : International",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 25
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Others",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 8
					insert_scheme_classification(cf_schemecode,cf_schemename,"Equity : Tax Saving (ELSS)",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 26
					insert_scheme_classification(cf_schemecode,cf_schemename,"ETF : Gold",0,0,0,0,cf_fdcode)
				elsif (cf['classcode'] == 43 or cf_schemecode == 17643 or cf_schemecode == 13397)
					insert_scheme_classification(cf_schemecode,cf_schemename,"ETF : Index",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 19 or cf['classcode'] == 47
					insert_scheme_classification(cf_schemecode,cf_schemename,"Hybrid : Arbitrage",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 44 or cf['classcode'] == 54
					insert_scheme_classification(cf_schemecode,cf_schemename,"Hybrid : Others",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 12 or cf['classcode'] == 57 
					insert_scheme_classification(cf_schemecode,cf_schemename,"Hybrid : Balanced (Equity oriented)",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 13 or cf['classcode'] == 14 or cf['classcode'] == 15 
					insert_scheme_classification(cf_schemecode,cf_schemename,"Hybrid : Balanced (Debt oriented)",0,0,0,0,cf_fdcode)
				elsif cf['classcode'] == 11 or cf['classcode'] == 48 or cf['classcode'] == 53
					insert_scheme_classification(cf_schemecode,cf_schemename,"Others",0,0,0,0,cf_fdcode)
				end 
			end
		end
	end
	
	 #Large, Mid-Small Cap Classification - Logic Implemented 
	
	@portfolio_holdpercent = ActiveRecord::Base.connection.select_all("select sum(mf.holdpercentage) as holdpercentage, sd.schemecode,sd.s_name,sd.primary_fd_code,sd.status,temp1.invdate from mf_portfolios mf join scheme_details_fulls sd on sd.primary_fd_code = mf.schemecode join (select max(date_format(invdate,'%y-%m-%d')) as invdate, schemecode from mf_portfolios group by schemecode) temp1 on mf.schemecode=temp1.schemecode where date_format(mf.invdate, '%y-%m-%d') = date_format(temp1.invdate,'%y-%m-%d') and sd.schemecode in (select sd.schemecode from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in (1,7,34,31,32,33,35,36,37,49)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and status = 'active' and opt_code = '1'  and sd.classcode in (1,7,34,31,32,33,35,36,37,49)  and !(sd.ispurchaseavailable='n' and sd.type_code='1') and nfo_close is not null union  select sd.schemecode from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in (1,7,34,31,32,33,35,36,37,49)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and sd.status = 'active' and sd.primary_fd_code not in (select sd.primary_fd_code from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in (1,7,34,31,32,33,35,36,37,49)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and status = 'active' and opt_code = '1') and sd.classcode in (1,7,34,31,32,33,35,36,37,49)  and !(sd.ispurchaseavailable='n' and sd.type_code='1') and nfo_close is not null group by sd.primary_fd_code) group by sd.schemecode order by temp1.invdate desc
")
	
	#@portfolio_holdpercent = ActiveRecord::Base.connection.select_all("SELECT sum(mf.holdpercentage) AS holdpercentage, mf.schemecode,sd.s_name,sd.primary_fd_code FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.classcode IN (1, 7, 34, 31, 32, 33, 35, 36, 37, 49) AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') GROUP BY mf.schemecode ORDER BY holdpercentage DESC")
	
	#@portfolio_holdpercent = ActiveRecord::Base.connection.select_all("SELECT sum(mf.holdpercentage) AS holdpercentage, mf.schemecode,sd.s_name,sd.primary_fd_code FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.classcode IN (1, 7, 34, 31, 32, 33, 35, 36, 37, 49) AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d') GROUP BY mf.schemecode ORDER BY holdpercentage DESC")
	
	#@portfolio_holdpercent = ActiveRecord::Base.connection.select_all("SELECT sum(mf.holdpercentage) AS holdpercentage, mf.schemecode,sd.s_name FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.schemecode = 3642 AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d')")
	
	@portfolio_holdpercent.each do|p|
	
	if p['schemecode'] != 0 && p['schemecode'] != nil
		@lcap_value = 0
		@mcap_value = 0
		@scap_value = 0
		@neg_sum = 0
		schemecode = p['schemecode'].to_s
		primary_fd_code = p['primary_fd_code']
		s_name = p['s_name']
		holdpercentage = p['holdpercentage']
		
			lcap_query = "SELECT sum(holdpercentage) as lcap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code join scheme_details_fulls sd on mf.schemecode = sd.primary_fd_code WHERE sd.schemecode = "+schemecode+" AND mc.classification = 'L' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') ORDER BY sd.schemecode DESC) AS temp"
			
			mcap_query = "SELECT sum(holdpercentage) as mcap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code join scheme_details_fulls sd on mf.schemecode = sd.primary_fd_code WHERE sd.schemecode = "+schemecode+" AND mc.classification = 'M' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') ORDER BY sd.schemecode DESC) AS temp"
			
			scap_query = "SELECT sum(holdpercentage) as scap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code join scheme_details_fulls sd on mf.schemecode = sd.primary_fd_code WHERE sd.schemecode = "+schemecode+" AND mc.classification = 'S' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') ORDER BY sd.schemecode DESC) AS temp"
			
			#lcap_query = "SELECT sum(holdpercentage) as lcap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND mc.classification = 'L' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
			
			#mcap_query = "SELECT sum(holdpercentage) as mcap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND mc.classification = 'M' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
			
			#scap_query = "SELECT sum(holdpercentage) as scap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND mc.classification = 'S' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
		
			# lcap_query = "SELECT sum(holdpercentage) as lcap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND mc.classification = 'L' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
			
			# mcap_query = "SELECT sum(holdpercentage) as mcap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND mc.classification = 'M' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
			
			# scap_query = "SELECT sum(holdpercentage) as scap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND mc.classification = 'S' AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
			
			@portfolio_lcappercent = ActiveRecord::Base.connection.select_all(lcap_query)
			@portfolio_mcappercent = ActiveRecord::Base.connection.select_all(mcap_query)
			@portfolio_scappercent = ActiveRecord::Base.connection.select_all(scap_query)
			
			@portfolio_lcappercent.each do|lc|
				@lcap_value = lc['lcap_percentage'].to_f
			end
			@portfolio_mcappercent.each do|mc|
				@mcap_value = mc['mcap_percentage'].to_f
			end
			@portfolio_scappercent.each do|sc|
				@scap_value = sc['scap_percentage'].to_f
			end
			puts @lcap_value
			puts @mcap_value
			puts @scap_value
			
			@portfolio_neg = ActiveRecord::Base.connection.select_all("SELECT sum( mf.holdpercentage ) AS holdpercentage, sd.schemecode, sd.s_name,sd.primary_fd_code FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.primary_fd_code = mf.schemecode WHERE sd.schemecode = "+schemecode+"  AND DATE_FORMAT( mf.invdate, '%Y-%m-%d' ) = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') AND mf.holdpercentage < 0")
			
			#@portfolio_neg = ActiveRecord::Base.connection.select_all("SELECT sum( mf.holdpercentage ) AS holdpercentage, mf.schemecode, sd.s_name FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.schemecode = "+schemecode+"  AND DATE_FORMAT( mf.invdate, '%Y-%m-%d' ) = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d') AND mf.holdpercentage < 0")
			
			#@portfolio_neg = ActiveRecord::Base.connection.select_all("SELECT sum( mf.holdpercentage ) AS holdpercentage, mf.schemecode, sd.s_name FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.schemecode = "+schemecode+"  AND DATE_FORMAT( mf.invdate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-03-31', '%Y-%m-%d' ) AND mf.holdpercentage < 0")
		
			if @portfolio_neg.length > 0 
				@portfolio_neg.each do |pn| 
					@neg_sum = pn['holdpercentage'].to_f.round(2)
					puts @neg_sum.to_s
				end
				@lcap_value = (@lcap_value * (100/(100-(@neg_sum)))).to_f
				@mcap_value = (@mcap_value * (100/(100-(@neg_sum)))).to_f
				@scap_value = (@scap_value * (100/(100-(@neg_sum)))).to_f
				
				puts @lcap_value
				puts @mcap_value
				puts @scap_value
				
			else
			
			end
			if(schemecode == "12413" or schemecode == "9247" or schemecode == "14632")
				insert_scheme_classification(schemecode,s_name,"Equity : Others",0,0,0,0,primary_fd_code)
			
			else
				if @lcap_value != 0 && @lcap_value != nil
					if @lcap_value >= 65
						if(schemecode == "17643" or schemecode == "13397" )
							insert_scheme_classification(schemecode,s_name,"ETF : Index",0,0,0,0,primary_fd_code)
						else
							insert_scheme_classification(schemecode,s_name,"Equity : Large Cap",@lcap_value,@mcap_value,@scap_value,0,primary_fd_code)
						end
					else
						@mscap_query ="SELECT sum(holdpercentage) as mscap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code join scheme_details_fulls sd on mf.schemecode = sd.primary_fd_code  WHERE sd.schemecode = "+schemecode+" AND (mc.classification = 'M' OR mc.classification = 'S') AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d')  ORDER BY sd.schemecode DESC) AS temp"
						
						#@mscap_query ="SELECT sum(holdpercentage) as mscap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND (mc.classification = 'M' OR mc.classification = 'S') AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT((select max(DATE_FORMAT(invdate,'%Y-%m-%d')) as invdate from mf_portfolios),'%Y-%m-%d')  ORDER BY schemecode DESC) AS temp"
						
						#@mscap_query ="SELECT sum(holdpercentage) as mscap_percentage FROM (SELECT mf.holdpercentage FROM mf_portfolios mf JOIN mcap_classifications mc ON mf.fincode = mc.ps_code WHERE mf.schemecode = "+schemecode+" AND (mc.classification = 'M' OR mc.classification = 'S') AND DATE_FORMAT(mf.invdate, '%Y-%m-%d') = DATE_FORMAT('2016-03-31', '%Y-%m-%d') ORDER BY schemecode DESC) AS temp"
						
						@portfolio_mscappercent = ActiveRecord::Base.connection.select_all(@mscap_query)
						@portfolio_mscappercent.each do|m|
							if(schemecode == "12413" or schemecode == "9247" or schemecode == "14632")
								insert_scheme_classification(schemecode,s_name,"Equity : Others",0,0,0,0,primary_fd_code)
							elsif(schemecode == "17643" or schemecode == "13397" )
								insert_scheme_classification(schemecode,s_name,"ETF : Index",0,0,0,0,primary_fd_code)
							else 
								if m['mscap_percentage'] != 0 && m['mscap_percentage'] != nil
									if m['mscap_percentage'] >= 65
										insert_scheme_classification(schemecode,s_name,"Equity : Mid-Small Cap",@lcap_value,@mcap_value,@scap_value,0,primary_fd_code)
									else
										insert_scheme_classification(schemecode,s_name,"Equity : Multi Cap",@lcap_value,@mcap_value,@scap_value,0,primary_fd_code)
									end
								end
							end
						end
					end
				end
			end
		else
		
		end
		
		
		end
		
		#end
	#end
	#end
	
	# Classification based on Average Maturity
	
	#@avg_maturity = ActiveRecord::Base.connection.select_all("SELECT am.`avg_mat_days`,`avg_mat_num`,am.`schemecode`,max(am.`date`) as date,sdf.s_name FROM `avg_maturities` am JOIN scheme_details_fulls sdf ON am.schemecode = sdf.schemecode WHERE sdf.classcode IN ( 16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55 ) group by am.`schemecode`")
	
	#@avg_maturity = ActiveRecord::Base.connection.select_all("SELECT am.`avg_mat_days` , am.`avg_mat_num` , am.`schemecode` , am.`date` AS date, sdf.s_name,sdf.primary_fd_code FROM `avg_maturities` am JOIN scheme_details_fulls sdf ON am.schemecode = sdf.schemecode WHERE sdf.classcode IN ( 16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55 ) AND am.date = (SELECT max( am.date ) FROM avg_maturities am JOIN scheme_details_fulls sdf ON am.schemecode = sdf.schemecode WHERE sdf.classcode IN ( 16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55 ) ) GROUP BY am.`schemecode`")
	
	@avg_maturity = ActiveRecord::Base.connection.select_all("select am.`avg_mat_days`, am.`avg_mat_num`, sdf.`schemecode`, am.`date` as date, sdf.s_name,sdf.primary_fd_code from `avg_maturities` am join scheme_details_fulls sdf on am.schemecode = sdf.primary_fd_code join (select max(date)avgdate,schemecode from avg_maturities group by schemecode) temp1 on temp1.schemecode = am.schemecode where sdf.classcode in (16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55) and date_format(am.date,'%y-%m-%d') = date_format(temp1.avgdate,'%y-%m-%d') and sdf.schemecode in (select sd.schemecode from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in   (16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and status = 'active' and opt_code = '1'  and sd.classcode in   (16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55) and !(sd.ispurchaseavailable='n' and sd.type_code='1') union select sd.schemecode from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in   (16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and sd.status = 'active' and sd.primary_fd_code not in (select sd.primary_fd_code from scheme_details_fulls as sd join (select distinct(primary_fd_code) as pf from scheme_details_fulls where classcode in   (16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55)) as temp1 on sd.primary_fd_code=temp1.pf and sd.amfi_code != 0 and sd.plan not in ('5','7') and status = 'active' and opt_code = '1') and sd.classcode in   (16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55) and !(sd.ispurchaseavailable='n' and sd.type_code='1')  group by sd.primary_fd_code) group by sdf.`schemecode` order by temp1.avgdate desc")
	
	@avg_maturity.each do|p|
	
		if p['avg_mat_days'].to_s.upcase == "DAYS"
			avg_mat_num_value = (p['avg_mat_num'] / 365).to_f.round(2)
		else
			avg_mat_num_value = p['avg_mat_num'].to_f
		end
		
		if(avg_mat_num_value < 0.25)
			insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt : Liquid-Average maturity",0,0,0,avg_mat_num_value,p['primary_fd_code'])
		elsif(avg_mat_num_value >= 0.25 and avg_mat_num_value <= 1) 
			insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt : Ultra Short Term-Average maturity",0,0,0,avg_mat_num_value,p['primary_fd_code'])
		elsif(avg_mat_num_value > 1 and avg_mat_num_value <= 5) 
			insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt : Short Term/GILT-Average maturity",0,0,0,avg_mat_num_value,p['primary_fd_code'])
		else
			insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt : Medium-Long Term/GILT-Average maturity",0,0,0,avg_mat_num_value,p['primary_fd_code'])
		end
	end
	
	rescue=>err
		lc.writelog(err.message,@logfile)
		puts err.message
	ensure
			ActiveRecord::Base.connection.close
			puts "Connection closed"
	end 
end

	def insert_scheme_classification(schemecode,s_name,classification,lcap,mcap,scap,avg_mat_num_value,primary_fd_code)
		@logfile = "scheme_classification"
		lc = LogcreatorController.new
		lc.createlogfile(@logfile)
		begin
			@select_sql = "Select * from scheme_classifications where schemecode = "+schemecode.to_s
			puts @select_sql.to_s
			@select_scheme = ActiveRecord::Base.connection.select_all(@select_sql)
			puts @select_scheme.length
			if @select_scheme.length > 0
				puts "inside update block"
				@update_sql = "update scheme_classifications set s_name = '"+s_name+"', classification = '"+classification+"', lcap_holdpercentage = "+lcap.to_s+", mcap_holdpercentage = "+mcap.to_s+", scap_holdpercentage = "+scap.to_s+", avg_mat_num = "+avg_mat_num_value.to_s+", remarks1 = '-', remarks2 = '-', remarks3 = '-',  primary_fd_code = "+primary_fd_code.to_s+" where schemecode = "+schemecode.to_s+"" 
				
				puts @update_sql.to_s
				update_scheme = ActiveRecord::Base.connection.update(@update_sql.to_s)
			else
				puts "inside insert block"
				@insert_sql = "insert into scheme_classifications(schemecode, s_name, classification, lcap_holdpercentage, mcap_holdpercentage, scap_holdpercentage, avg_mat_num, remarks1, remarks2, remarks3, primary_fd_code) values ("+schemecode.to_s+",'"+s_name+"','"+classification+"', "+lcap.to_s+", "+mcap.to_s+", "+scap.to_s+", "+avg_mat_num_value.to_s+",'-','-','-',"+primary_fd_code.to_s+")"
				
				puts @insert_sql.to_s
				insert_scheme = ActiveRecord::Base.connection.insert(@insert_sql.to_s)
			end
			# sc = SchemeClassification.new
			# sc.schemecode = schemecode
			# sc.s_name = s_name
			# sc.classification = classification
			# sc.lcap_holdpercentage = lcap
			# sc.mcap_holdpercentage = mcap
			# sc.scap_holdpercentage = scap
			# sc.avg_mat_num = avg_mat_num_value
			# sc.remarks1 = "-"
			# sc.remarks2 = "-"
			# sc.remarks3 = "-"
			# sc.primary_fd_code = primary_fd_code
			# sc.save
		rescue => err
			lc.writelog(err.message,@logfile)
			puts err.message
		end
	end

	def avg_maturity_calc

	#@avg_maturity = ActiveRecord::Base.connection.select_all("SELECT am.`avg_mat_days` , `avg_mat_num` , am.`schemecode` , am.`date` AS date, sdf.s_name FROM `avg_maturities` am JOIN scheme_details_fulls sdf ON am.schemecode = sdf.schemecode WHERE sdf.classcode IN ( 16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55 ) AND am.date = (SELECT max( am.date ) FROM avg_maturities am JOIN scheme_details_fulls sdf ON am.schemecode = sdf.schemecode WHERE sdf.classcode IN ( 16, 17, 18, 22, 23, 24, 27, 28, 45, 46, 55 ) ) GROUP BY am.`schemecode`")

	@avg_maturity = ActiveRecord::Base.connection.select_all("SELECT mf.holdpercentage, mf.schemecode, sd.s_name FROM mf_portfolios mf JOIN scheme_details_fulls sd ON sd.schemecode = mf.schemecode WHERE sd.schemecode =3642 AND DATE_FORMAT( mf.invdate, '%Y-%m-%d' ) = DATE_FORMAT( '2016-03-31', '%Y-%m-%d' ) AND mf.holdpercentage < 0 ORDER BY mf.holdpercentage ASC ")
		if @avg_maturity.length > 0 
		
			@avg_maturity.each do|p|
				puts p['schemecode'].to_s
			end
		end
		
			# if p['avg_mat_days'].to_s.upcase == "DAYS"
				# avg_mat_num_value = (p['avg_mat_num'] / 365).to_f.round(2)
			# else
				# avg_mat_num_value = p['avg_mat_num']
			# end
			
			# if(avg_mat_num_value <= 0.25)
				# insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt : Liquid - Average maturity",0,0,0,avg_mat_num_value)
			# elsif(avg_mat_num_value > 0.25 and avg_mat_num_value <= 1) 
				# insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt : Ultra Short Term - Average maturity",0,0,0,avg_mat_num_value)
			# elsif(avg_mat_num_value > 1 and avg_mat_num_value <= 5) 
				# insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt: Short Term /GILT -Average maturity",0,0,0,avg_mat_num_value)
			# else
				# insert_scheme_classification(p['schemecode'],p['s_name'].to_s,"Debt: Medium & Long Term /GILT- Average maturity",0,0,0,avg_mat_num_value)
			# end
		
	end
end
