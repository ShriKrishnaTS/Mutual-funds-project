class MfStpsController < ApplicationController

  def read_mf_stp
    Thread.new do
			mf_stp()
		end
  end

  def mf_stp
  
  @result = 1
    @logfile = "mf_stp"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_stp.ace","r")
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
            insert_mf_st(@final_split)
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
  
  def insert_mf_st(insertdata)
    begin
      lc = LogcreatorController.new
      ms = MfStp.new
      ms.schemecode = insertdata[0]
      ms.amc_code = insertdata[1]
      ms.frequency = insertdata[2]
      ms.stpinout = insertdata[3]
      ms.stp = insertdata[4]
      ms.stpfrequency = insertdata[5]
      ms.stpdates = insertdata[6]
      ms.stpdays1 = insertdata[7]
      ms.stpdays2 = insertdata[8]
      ms.stpdays3 = insertdata[9]
      ms.stpdays4 = insertdata[10]
      ms.stpdays5 = insertdata[11]
      ms.stpdays6 = insertdata[12]
      ms.stpdays7 = insertdata[13]
      ms.stpmininvest = insertdata[14]
      ms.stpaddninvest = insertdata[15]
      ms.stpfrequencyno = insertdata[16]
      ms.upd_flag = insertdata[17]
      ms.save
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
