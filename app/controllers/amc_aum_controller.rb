class AmcAumController < ApplicationController

  def read_amc_aum
	Thread.new do
		amc_aum()
	end

  end


  def amc_aum
  
	 @result = 1
    @logfile = "amc_aum"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/amc_aum.ace","r")
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
            insert_amc_aum(@final_split)
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
  
  def insert_amc_aum(insertdata)

    begin
      lc = LogcreatorController.new
      aa = AmcAum.new
      aa.amc_code = insertdata[0]
	  puts insertdata[1]
	  puts insertdata[1].from(0).to(-5)
      if insertdata[1].empty?
        aa.aumdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        aa.aumdate = DateTime.strptime(insertdata[1].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      aa.totalaum = insertdata[2]
      aa.upd_flag = insertdata[3]
	  puts aa.to_s
      aa.save
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
