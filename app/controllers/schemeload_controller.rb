class SchemeloadController < ApplicationController

  def read_schemeload
    
	Thread.new do
			scheme_load()
		end

  end

  def scheme_load
  
	@result = 1
    @logfile = "schemeload"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/schemeload.ace","r")
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
            insert_schemeload(@final_split)
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
  def insert_schemeload(insertdata)

    begin
      lc = LogcreatorController.new
      sl = Schemeload.new
      sl.schemecode = insertdata[0]
      if insertdata[1].blank?
        sl.ldate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sl.ldate = DateTime.strptime(insertdata[1],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      sl.ltypecode = insertdata[2]
      sl.lsrno = insertdata[3]
      sl.frmamount = insertdata[4]
      sl.uptoamount = insertdata[5]
      sl.minperiod = insertdata[6]
      sl.maxperiod = insertdata[7]
      sl.min = insertdata[8]
      sl.max = insertdata[9]
      sl.entryload = insertdata[10]
      sl.exitload = insertdata[11]
      sl.remarks = insertdata[12]
      sl.upd_flag = insertdata[13]
      sl.save
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
