class WeekhighLowController < ApplicationController

  def read_week_high
    Thread.new do
		week_high_low()
	end
  end

  def week_high_low
  
	@result = 1
    @logfile = "navhist_hl"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/navhist_hl.ace","r")
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
            insert_week_low(@final_split)
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
  
  def insert_week_low(insertdata)

    begin
      lc = LogcreatorController.new
      whl = NavhistHl.new

      whl.schemecode = insertdata[0]
      whl.monthhhigh_3 = insertdata[1]
      whl.monthlow_3 = insertdata[2]
      if insertdata[3].blank?
        whl.mhdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.mhdate_3 = DateTime.strptime(insertdata[3],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[4].blank?
        whl.mldate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.mldate_3 = DateTime.strptime(insertdata[4],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.monthlow_6 = insertdata[6]
      if insertdata[7].blank?
        whl.mhdate_6 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.mhdate_6 = DateTime.strptime(insertdata[7],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[8].blank?
        whl.mldate_6 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.mldate_6 = DateTime.strptime(insertdata[8],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.monthhhigh_9 = insertdata[9]
      whl.monthlow_9 = insertdata[10]
      if insertdata[11].blank?
        whl.mhdate_9 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.mhdate_9 = DateTime.strptime(insertdata[11],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[12].blank?
        whl.mldate_9 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.mldate_9 = DateTime.strptime(insertdata[12],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.weekhhigh_52 = insertdata[13]
      whl.weeklow_52 = insertdata[14]
      if insertdata[15].blank?
        whl.whdate_52 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.whdate_52 = DateTime.strptime(insertdata[15],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[16].blank?
        whl.wldate_52 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.wldate_52 = DateTime.strptime(insertdata[16],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.yrhigh_1 = insertdata[17]
      whl.yrlow_1 = insertdata[18]
      if insertdata[19].blank?
        whl.yhdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yhdate_1 = DateTime.strptime(insertdata[19],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[20].blank?
        whl.yldate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yldate_1 = DateTime.strptime(insertdata[20],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.yrhigh_2 = insertdata[21]
      whl.yrlow_2 = insertdata[22]
      if insertdata[23].blank?
        whl.yhdate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yhdate_2 = DateTime.strptime(insertdata[23],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[24].blank?
        whl.yldate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yldate_2 = DateTime.strptime(insertdata[24],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.yrhigh_3 = insertdata[25]
      whl.yrlow_3 = insertdata[26]
      if insertdata[27].blank?
        whl.yhdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yhdate_3 = DateTime.strptime(insertdata[27],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[28].blank?
        whl.yldate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yldate_3 = DateTime.strptime(insertdata[28],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.yrhigh_5 = insertdata[29]
      whl.yrlow_5 = insertdata[30]
      if insertdata[31].blank?
        whl.yhdate_5 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yhdate_5 = DateTime.strptime(insertdata[31],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[32].blank?
        whl.yldate_5 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.yldate_5 = DateTime.strptime(insertdata[32],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.ytdlow = insertdata[34]
      if insertdata[35].blank?
        whl.ytdhdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.ytdhdate = DateTime.strptime(insertdata[35],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[36].blank?
        whl.ytdldate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.ytdldate = DateTime.strptime(insertdata[36],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.sihigh = insertdata[37]
      whl.silow = insertdata[38]
      if insertdata[39].blank?
        whl.sihdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.sihdate = DateTime.strptime(insertdata[39],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[40].blank?
        whl.sildate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        whl.sildate = DateTime.strptime(insertdata[40],"%m/%d/%Y %H:%M:%S %p").to_formatted_s(:db)
      end

      whl.upd_flag = insertdata[41]
      whl.save
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
