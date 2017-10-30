class FmpYielddetialsController < ApplicationController

  def read_fmp_yielddetials
    Thread.new do
		fmp_yielddetails()
	end
  end

  def fmp_yielddetails
	@result = 1
    @logfile = "fmp_yielddetails"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/fmp_yielddetails.ace","r")
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
            insert_fmp_yielddetials(@final_split)
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
  
  def insert_fmp_yielddetials(insertdata)
    begin
      lc = LogcreatorController.new
      fy = FmpYielddetail.new
      fy.schemecode = insertdata[0]
      if insertdata[1].blank?
        fy.maturitydate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        fy.maturitydate = DateTime.strptime(insertdata[1],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      fy.tenure_number = insertdata[2]
      fy.tenure_option = insertdata[3]
      fy.net_inticative_yield1 = insertdata[4]
      fy.net_inticative_yield2 = insertdata[5]
      fy.post_taxyield_ind1 = insertdata[6]
      fy.post_taxyield_ind2 = insertdata[7]
      fy.post_taxyield_nonind1 = insertdata[8]
      fy.post_taxyield_nonind2 = insertdata[9]
      fy.exit_load = insertdata[10]
      fy.upd_flag = insertdata[11]
      fy.save
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
