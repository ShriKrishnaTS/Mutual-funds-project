class SipswpdetailsController < ApplicationController

  def read_sipswpdetails
    
	Thread.new do
			sipswp()
		end

  end

  def sipswp
  
  @result = 1
    @logfile = "mf_sipdetails"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_sipdetails.ace","r")
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
            @result=1
            insert_sipswpdetails(@final_split)
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
    rescue  =>err
      lc.writelog(err.message,@logfile)
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,@logfile)

    end
	
  end
  
  def insert_sipswpdetails(insertdata)

    begin
      lc = LogcreatorController.new
      ssd = SipSwpDetail.new
      ssd.schemecode = insertdata[0]
      ssd.amc_code = insertdata[1]
      ssd.sipdays1 = insertdata[2]
      ssd.sipdays2 = insertdata[3]
      ssd.sipdays3 = insertdata[4]
      ssd.sipdays4 = insertdata[5]
      ssd.sipdays5 = insertdata[6]
      ssd.sipdays6 = insertdata[7]
      ssd.sipdays7 = insertdata[8]
      ssd.sipdaysall = insertdata[9]
      ssd.sipfrequency = insertdata[10]
      ssd.sipmininvest = insertdata[11]
      ssd.sipaddninvest = insertdata[12]
      ssd.sipfrequencyno = insertdata[13]
      ssd.swpdays1 = insertdata[14]
      ssd.swpdays2 = insertdata[15]
      ssd.swpdays3 = insertdata[16]
      ssd.swpdays4 = insertdata[17]
      ssd.swpdays5 = insertdata[18]
      ssd.swpdays6 = insertdata[19]
      ssd.swpdays7 = insertdata[20]
      ssd.swpdaysall = insertdata[21]
      ssd.swpfrequecy = insertdata[22]
      ssd.swpmininvest = insertdata[23]
      ssd.swpaddninvest = insertdata[24]
      ssd.swpfrequencyno = insertdata[25]
      ssd.maxentryload = insertdata[26]
      ssd.maxexitload = insertdata[27]
      ssd.entry_remark = insertdata[28]
      ssd.exit_remark = insertdata[29]
      ssd.note = insertdata[30]
      ssd.upd_flag = insertdata[31]
      ssd.save
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
