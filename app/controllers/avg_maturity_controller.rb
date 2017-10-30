class AvgMaturityController < ApplicationController

  def read_avg_maturity
    Thread.new do
			average_maturity()
		end
  end

  def average_maturity
	@result = 1
    @logfile = "avg_maturity"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
   begin
     afile = File.open("app/assets/files/avg_maturity.ace","r")
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
           insert_avg_mat(@final_split)
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
  
  def insert_avg_mat(insertdata)
    begin
      lc = LogcreatorController.new
      avm = AvgMaturity.new
      avm.amc_code = insertdata[0]
      avm.schemecode = insertdata[1]
      if insertdata[2].blank?
        avm.date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        avm.date = DateTime.strptime(insertdata[2],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[3].blank?
        avm.invenddate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        avm.invenddate = DateTime.strptime(insertdata[3],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      avm.avg_mat_num = insertdata[4]
      avm.avg_mat_days = insertdata[5]
      avm.mod_dur_num = insertdata[6]
      avm.mod_dur_days = insertdata[7]
      avm.ytm = insertdata[8]
      avm.turnover_ratio = insertdata[9]
      avm.tr_mode = insertdata[10]
      avm.upd_flag = insertdata[11]

      avm.save
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
