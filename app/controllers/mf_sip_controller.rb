class MfSipController < ApplicationController

  def read_sip
    
	Thread.new do
			mf_sip()
		end
  end

  def mf_sip
  
	@result = 1
    @logfile = "mf_sip"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_sip.ace","r")
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
            insert_sip(@final_split)
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
  
  def insert_sip(insertdata)

    begin
      lc = LogcreatorController.new
      ms = MfSip.new
      ms.schemecode = insertdata[0]
      ms.amc_code = insertdata[1]
      ms.frequency = insertdata[2]
      ms.sip = insertdata[3]
      ms.sipdates = insertdata[4]
      ms.sipdays1 = insertdata[5]
      ms.sipdays2 = insertdata[6]
      ms.sipdays3 = insertdata[7]
      ms.sipdays4 = insertdata[8]
      ms.sipdays5 = insertdata[9]
      ms.sipdays6 = insertdata[10]
      ms.sipdays7 = insertdata[11]
      ms.sipmininvest = insertdata[12]
      ms.sipaddninvest = insertdata[13]
      ms.sipfrequencyno = insertdata[14]
      ms.maxentryload = insertdata[15]
      ms.maxexitload = insertdata[16]
      ms.entry_remark = insertdata[17]
      ms.exit_remark = insertdata[18]
      ms.note = insertdata[19]
      ms.upd_flag = insertdata[20]
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
