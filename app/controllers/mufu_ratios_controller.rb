class MufuRatiosController < ApplicationController

  def read_mufu_rat
    Thread.new do
			mufu_ratios()
		end


  end

  def mufu_ratios
  
	@result = 1
    @logfile = "mf_ratios"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_ratios.ace","r")
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
            insert_mufu_r(@final_split)
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
  
  def insert_mufu_r(insertdata)
    begin
      lc = LogcreatorController.new
      mfr = MfRatio.new
      mfr.schemecode = insertdata[0]
      if insertdata[1].blank?
        mfr.upddate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfr.upddate = DateTime.strptime(insertdata[1].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      if insertdata[2].blank?
        mfr.datefrom = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfr.datefrom = DateTime.strptime(insertdata[2].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      if insertdata[3].blank?
        mfr.dateto = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        mfr.dateto = DateTime.strptime(insertdata[3].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      mfr.avg_x = insertdata[4]
      mfr.avg_y = insertdata[5]
      mfr.sd_x = insertdata[6]
      mfr.sd_y = insertdata[7]
      mfr.semisd_x = insertdata[8]
      mfr.semisd_y = insertdata[9]
      mfr.beta_x = insertdata[10]
      mfr.beta_y = insertdata[11]
      mfr.corelation_x = insertdata[12]
      mfr.corelation_y = insertdata[13]
      mfr.betacor_x = insertdata[14]
      mfr.betacor_y = insertdata[15]
      mfr.treynor_x = insertdata[16]
      mfr.treynor_y = insertdata[17]
      mfr.fama_x = insertdata[18]
      mfr.fama_y = insertdata[19]
      mfr.sharpe_x = insertdata[20]
      mfr.sharpe_y = insertdata[21]
      mfr.jalpha_x = insertdata[22]
      mfr.jalpha_y = insertdata[23]
      mfr.sortino_x = insertdata[24]
      mfr.sortino_y = insertdata[25]
      mfr.upd_flag = insertdata[26]
      mfr.save
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
