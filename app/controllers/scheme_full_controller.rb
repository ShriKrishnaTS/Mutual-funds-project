class SchemeFullController < ApplicationController

  def read_scheme_full
    
	Thread.new do
			scheme_full()
		end


  end
  def scheme_full
  
	@result = 1
    @logfile = "scheme_details_full"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/scheme_details_full.ace","r")
      if afile
        @fileavbl = "File available"
        @count = File.foreach(afile).inject(0) {|c, line| c+1}
        @i=0
        afile.each { |line|
          puts line
          if line == '<<eof>>'
            @endoffile = "Transfer done"
          else
            @i = @i+1
            @total_records = @total_records + 1
            @tokens = line.split("<<row>>")
            @first_splt_result = @tokens[1].split("<</row>>")
            @final_split = @first_splt_result[0].split("|")
            @result = 1
            insert_scheme_full(@final_split)
            if (@result == 0)
              @insert_count = @insert_count + 1
              puts @insert_count
            else
              @uninsert_count = @uninsert_count + 1
              puts @uninsert_count
            end
          end
        }
        messages = "Total Records as per File : " + @total_records.to_s
        messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
        messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
        lc.writelog(messages,@logfile)
      else
        @fileavbl = "File Not Available"
      end
    rescue =>err
      lc.writelog(err.message,@logfile)
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,@logfile)

    end
  end
  def insert_scheme_full(insertdata)
    begin
      lc = LogcreatorController.new
      sf = SchemeDetailsFull.new
	  select_sql = "select * from scheme_details_fulls where schemecode = "+insertdata[0] 
	  @data = ActiveRecord::Base.connection.select_all(select_sql)
	  if(@data.length > 0)
		puts @data.length
		puts "Inside Delete loop"
		delete_sql = "Delete from scheme_details_fulls where schemecode = "+insertdata[0]
		@del_data = ActiveRecord::Base.connection.delete(delete_sql)
	  end
      sf.schemecode = insertdata[0]
      sf.amfi_code = insertdata[1]
      sf.cmas_code = insertdata[2]
      sf.amc_code = insertdata[3]
      sf.s_name = insertdata[4]
      sf.amfi_name = insertdata[5]
      sf.isin_code = insertdata[6]
      sf.type_code = insertdata[7]
      sf.opt_code = insertdata[8]
      sf.classcode = insertdata[9]
      sf.theme_code = insertdata[10]
      sf.rt_code = insertdata[11]
      sf.plan = insertdata[12]
      sf.cust_code = insertdata[13]
      sf.cust_code2 = insertdata[14]
      sf.price_freg = insertdata[15]
      sf.init_price = insertdata[16]
      sf.offerprice = insertdata[17]

      if insertdata[18].empty?
        sf.nfo_open = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.nfo_open = DateTime.strptime(insertdata[18].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      if insertdata[19].empty?
        sf.nfo_close = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.nfo_close = DateTime.strptime(insertdata[19].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      if insertdata[20].empty?
        sf.reopen_dt = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.reopen_dt = DateTime.strptime(insertdata[20].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      sf.elf = insertdata[21]
      sf.etf = insertdata[22]
      sf.stp =insertdata[23]
      sf.primary_fund = insertdata[24]
      sf.primary_fd_code = insertdata[25]
      sf.sip = insertdata[26]
      sf.swp = insertdata[27]
      sf.switch = insertdata[28]
      sf.mininvt = insertdata[29]
      sf.multiples = insertdata[30]
      sf.inc_invest = insertdata[31]
      sf.adnmultiples = insertdata[32]
      sf.fund_mgr1 = insertdata[33]
      sf.fund_mgr2 = insertdata[34]
      sf.fund_mgr3 = insertdata[35]
      sf.fund_mgr4 = insertdata[36]

      if insertdata[37].empty?
        sf.since = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.since = DateTime.strptime(insertdata[37].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      sf.status = insertdata[38]
      sf.cutsub = insertdata[39]
      sf.cutred = insertdata[40]
      sf.red = insertdata[41]
      puts insertdata[42]
      sf.mob_name = insertdata[42]
      sf.div_freq = insertdata[43]
      sf.scheme_symbol = insertdata[44]
      sf.fund_mgr_code1 = insertdata[45]
      sf.fund_mgr_code2 = insertdata[46]
      sf.fund_mgr_code3 = insertdata[47]
      puts insertdata[48]
      sf.fund_mgr_code4 = insertdata[48]

      if insertdata[49].empty?
        sf.redemption_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.redemption_date = DateTime.strptime(insertdata[49].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      if insertdata[50].empty?
        sf.dateofallot = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.dateofallot = DateTime.strptime(insertdata[50].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
	  sf.div_code = insertdata[51]
      sf.legalnames = insertdata[52]
      sf.amfitype = insertdata[53]
      sf.nontxnday = insertdata[54]
      sf.schemebank = insertdata[55]
      sf.schemebankaccountnumber = insertdata[56]
      sf.schemebankbranch = insertdata[57]
      sf.dividendoptionflag = insertdata[58]
      sf.lockinperiod = insertdata[59]
      sf.ispurchaseavailable = insertdata[60]
      sf.isredeemavailable = insertdata[61]
      sf.minredemptionamount = insertdata[62]
      sf.redemptionmultipleamount = insertdata[63]
      sf.minredemptionunits = insertdata[64]
      sf.redemptionmultiplesunits = insertdata[65]
      sf.minswitchamount = insertdata[66]
      sf.switchmultipleamount = insertdata[67]
      sf.minswitchunits = insertdata[68]
      sf.switchmultiplesunits = insertdata[69]
      sf.securitycode = insertdata[70]
      sf.unit = insertdata[71]
      sf.switchout = insertdata[72]
      sf.minswitchoutamount = insertdata[73]
      sf.switchoutmultipleamount = insertdata[74]
      sf.minswitchoutunits = insertdata[75]
      sf.switchoutmultiplesunits = insertdata[76]

      if insertdata[77].empty?
        sf.incept_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.incept_date = DateTime.strptime(insertdata[77].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      sf.incept_nav = insertdata[78]
      sf.defaultopt = insertdata[79]
      sf.defaultplan = insertdata[80]
      sf.lockperiod = insertdata[81]

      if insertdata[82].empty?
        sf.oddraftdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sf.oddraftdate = DateTime.strptime(insertdata[82].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      sf.upd_flag = insertdata[83]
      sf.save
      @result = 0
    rescue =>err
      puts  err.message
      lc.writelog(err.message,@logfile)
      errmsg = insertdata[0] + " Not Inserted"
      lc.writelog(errmsg,@logfile)
      @result = 1
    end

  end
end
