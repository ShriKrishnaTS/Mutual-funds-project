class SchemeReturnController < ApplicationController

  def read_scheme_return
    Thread.new do
		scheme_return()
	end

  end

  def scheme_return
  
	@result = 1
    @logfile = "mf_return"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_return.ace","r")
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
            insert_scheme_ret(@final_split)
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
  
  def insert_scheme_ret(insertdata)
    begin
      lc = LogcreatorController.new
      mr = MfReturn.new
      mr.schemecode = insertdata[0]
      if insertdata[1].blank?
        mr.c_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.c_date = DateTime.strptime(insertdata[1],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[2].blank?
        mr.p_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.p_date = DateTime.strptime(insertdata[2],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.c_nav = insertdata[3]
      mr.p_nav = insertdata[4]
      mr.dyaret_1 = insertdata[5]
      if insertdata[6].blank?
        mr.weekdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.weekdate_1 = DateTime.strptime(insertdata[6],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.weeknav_1 = insertdata[7]
      mr.weekret_1 = insertdata[8]
      if insertdata[9].blank?
        mr.mthdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.mthdate_1 = DateTime.strptime(insertdata[9],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.mthnav_1 = insertdata[10]
      mr.monthret_1 = insertdata[11]
      if insertdata[12].blank?
        mr.mthdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.mthdate_3 = DateTime.strptime(insertdata[12],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.mthnav_3 = insertdata[13]
      mr.monthret_3 = insertdata[14]
      if insertdata[15].blank?
        mr.mntdate_6 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.mntdate_6 = DateTime.strptime(insertdata[15],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.mnthnav_6 = insertdata[16]
      mr.monthret_6 = insertdata[17]
      if insertdata[18].blank?
        mr.mnthdate_9 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.mnthdate_9 = DateTime.strptime(insertdata[18],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.mnthnav_9 = insertdata[19]
      mr.mnthret_9 = insertdata[20]
      if insertdata[21].blank?
        mr.yrdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.yrdate_1 = DateTime.strptime(insertdata[21],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.yrnav_1 = insertdata[22]
      mr.yrret_1 = insertdata[23]
      if insertdata[24].blank?
        mr.yrdate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.yrdate_2 = DateTime.strptime(insertdata[24],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.yrnav_2 = insertdata[25]
      mr.yearret_2 = insertdata[26]
      if insertdata[27].blank?
        mr.yrdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.yrdate_3 = DateTime.strptime(insertdata[27],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.yrnav_3 = insertdata[28]
      mr.yearret_3 = insertdata[29]
      if insertdata[30].blank?
        mr.yrdate_4 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.yrdate_4 = DateTime.strptime(insertdata[30],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.yrnav_4 = insertdata[31]
      mr.yearret_4 = insertdata[32]
      if insertdata[33].blank?
        mr.yrdate_5 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.yrdate_5 = DateTime.strptime(insertdata[33],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.yrnav_5 = insertdata[34]
      mr.yearret_5 = insertdata[35]
      if insertdata[36].blank?
        mr.incdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mr.incdate = DateTime.strptime(insertdata[36],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      mr.incnav = insertdata[37]
      mr.incret = insertdata[38]
      mr.upd_flag = insertdata[39]
      mr.save
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
