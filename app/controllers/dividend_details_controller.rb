class DividendDetailsController < ApplicationController

  def read_div_details
    Thread.new do
		div_details()
	end
  end
	
	def div_details
	@result = 1
    @logfile = "divdetails"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin

      afile = File.open("app/assets/files/divdetails.ace","r")
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
            insert_div_details(@final_split)
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
  def insert_div_details(insertdata)

    begin
      lc = LogcreatorController.new
      dd = Divdetail.new
      dd.amc_code = insertdata[0]
      dd.schemecode = insertdata[1]
      if insertdata[2].blank?
        dd.recorddate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %I:%M:%S").to_formatted_s(:db)
      else
        dd.recorddate = DateTime.strptime(insertdata[2],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      dd.div_code = insertdata[3]
      if insertdata[4].blank?
        dd.exdivdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %I:%M:%S").to_formatted_s(:db)
      else
        dd.exdivdate = DateTime.strptime(insertdata[4],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      dd.bonusrate1 = insertdata[5]
      dd.bonusrate2 = insertdata[6]
      dd.gross = insertdata[7]
      dd.corporate = insertdata[8]
      dd.noncorporate = insertdata[9]
      dd.status = insertdata[10]
      dd.upd_flag = insertdata[11]
      dd.save
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
