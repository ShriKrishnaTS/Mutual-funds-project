class MfSwpcController < ApplicationController

  def read_mf_swp
    
	Thread.new do
			mf_swpc()
		end


  end

  def mf_swpc
  
	@result = 1
    @logfile = "mf_swp"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_swp.ace","r")
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
            insert_mf_sw(@final_split)
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
  
  def insert_mf_sw(insertdata)
    begin
      lc = LogcreatorController.new
      mfs = MfSwp.new
      mfs.schemecode = insertdata[0]
      mfs.amc_code = insertdata[1]
      mfs.frequency = insertdata[2]
      mfs.swp = insertdata[3]
      mfs.swpdates = insertdata[4]
      mfs.swpdays1 = insertdata[5]
      mfs.swpdays2 = insertdata[6]
      mfs.swpdays3 = insertdata[7]
      mfs.swpdays4 = insertdata[8]
      mfs.swpdays5 = insertdata[9]
      mfs.swpdays6 = insertdata[10]
      mfs.swpdays7 = insertdata[11]
      mfs.swpmininvest = insertdata[12]
      mfs.swpaddninvest = insertdata[13]
      mfs.swpfrequencyno = insertdata[14]
      mfs.upd_flag = insertdata[15]
      mfs.save
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
