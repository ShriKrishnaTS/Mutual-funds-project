class AbsoluteReturnController < ApplicationController
  def read_absolute_return
    Thread.new do
			absolute_return()
		end

  end
  
  def absolute_return
  
  @result = 1
    @logfile = "mf_abs_return"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_abs_return.ace","r")
      if afile
        @fileavbl = "File available"
        @count = File.foreach(afile).inject(0) {|c, line| c+1}
        @i=0
        afile.each { |line|
          puts line
          if line == '<<eof>>'
            @endoffile = "Transfer done"
            afile.close
          else
            @i = @i+1
            @total_records = @total_records + 1
            @tokens = line.split("<<row>>")
            @first_splt_result = @tokens[1].split("<</row>>")
            @final_split = @first_splt_result[0].split("|")
            @result = 1
            insert_absolute_return(@final_split)
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
  def insert_absolute_return(insertdata)

    begin

      lc = LogcreatorController.new
      mfar = MfAbsReturn.new
      mfar.schemecode = insertdata[0]
      if insertdata[1].blank?
        mfar.c_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.c_date = DateTime.strptime(insertdata[1],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[2].blank?
        mfar.p_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.p_date = DateTime.strptime(insertdata[2],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.c_nav = insertdata[3]
      mfar.p_nav = insertdata[4]
      mfar.dayret_1 = insertdata[5]
      if insertdata[6].blank?
        mfar.weekdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.weekdate_1 = DateTime.strptime(insertdata[6],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.weeknav_1 = insertdata[7]
      mfar.weekret_1 = insertdata[8]
      if insertdata[9].blank?
        mfar.mthdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.mthdate_1 = DateTime.strptime(insertdata[9],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.mthnav_1 = insertdata[10]
      mfar.monthret_1 = insertdata[11]
      if insertdata[12].blank?
        mfar.mthdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.mthdate_3 = DateTime.strptime(insertdata[12],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.mthnav_3 = insertdata[13]
      mfar.monthret_3 = insertdata[14]
      if insertdata[15].blank?
        mfar.mntdate_6 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.mntdate_6 = DateTime.strptime(insertdata[15],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.mnthnav_6 = insertdata[16]
      mfar.monthret_6 = insertdata[17]
      if insertdata[18].blank?
        mfar.mnthdate_9 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.mnthdate_9 = DateTime.strptime(insertdata[18],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.mnthnav_9 = insertdata[19]
      mfar.mnthret_9 = insertdata[20]
      if insertdata[21].blank?
        mfar.yrdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.yrdate_1 = DateTime.strptime(insertdata[21],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.yrnav_1 = insertdata[22]
      mfar.yrret_1 = insertdata[23]
      if insertdata[24].blank?
        mfar.yrdate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.yrdate_2 = DateTime.strptime(insertdata[24],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.yrnav_2 = insertdata[25]
      mfar.yearret_2 = insertdata[26]
      if insertdata[27].blank?
        mfar.yrdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.yrdate_3 = DateTime.strptime(insertdata[27],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.yrnav_3 = insertdata[28]
      mfar.yearret_3 = insertdata[29]
      if insertdata[30].blank?
        mfar.yrdate_4 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.yrdate_4 = DateTime.strptime(insertdata[30],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.yrnav_4 = insertdata[31]
      mfar.yearret_4 = insertdata[32]
      if insertdata[33].blank?
        mfar.yrdate_5 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.yrdate_5 = DateTime.strptime(insertdata[33],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.yrnav_5 = insertdata[34]
      mfar.yearret_5 = insertdata[35]
      if insertdata[36].blank?
        mfar.incdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfar.incdate = DateTime.strptime(insertdata[36],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      mfar.incnav = insertdata[37]
      mfar.incret = insertdata[38]
      mfar.upd_flag = insertdata[39]
      mfar.save
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
