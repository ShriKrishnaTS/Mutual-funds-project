class AmcKeypersonController < ApplicationController

  def read_amc_keyperson
    Thread.new do
		amc_keypersons()
	end

  end
  def amc_keypersons
	@result = 1
    @logfile = "amc_keypersons"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    afile = File.open("app/assets/files/amc_keypersons.ace","r")
    begin
    if afile
      @fileavbl = "File available"
      @count = File.foreach(afile).inject(0) {|c, line| c+1}
      @i=0

        afile.each { |line|
          puts line
          if line == "<<eof>>"
            @endoffile = "Transfer done"

          else
            @i = @i+1
            @total_records = @total_records + 1
            @tokens = line.split("<<row>>")
            @first_splt_result = @tokens[1].split("<</row>>")
            @final_split = @first_splt_result[0].split("|")
            @result = 1
            @result = amc_keyperson(@final_split)
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

    rescue => e# StandardError
      lc.writelog(e.message,"amc_keypersons")
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,@logfile)
    end

  end
  def amc_keyperson(insertdata)
    begin
      lc = LogcreatorController.new
      amckey = AmcKeyperson.new
      puts insertdata[0]
      amckey.amc_code = insertdata[0]
      amckey.amc_name = insertdata[1]
      amckey.srno = insertdata[2]
      amckey.name = insertdata[3]
      amckey.desg = insertdata[4]
      amckey.upd_flag = insertdata[5]
      amckey.save
      @result = 0
    rescue => err
      puts  err.message
      lc.writelog(err.message,@logfile)
      errmsg = insertdata[0] + " Not Inserted"
      lc.writelog(errmsg,@logfile)
      @result = 1

    end

  end
end
