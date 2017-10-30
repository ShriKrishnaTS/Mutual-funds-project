class MutualFundcompanyController < ApplicationController
  def read_mutual_fund
   Thread.new do
			mutual_fund()
		end
  end

  def mutual_fund
  
	 @result = 1
    @logfile = "mf_companymaster"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_companymaster.ace","r")
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
            insert_mutual_funcom(@final_split)
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
  
  def insert_mutual_funcom(insertdata)
    begin
      lc = LogcreatorController.new
      mfc = MfCompanymaster.new
	  select_sql = "select * from mf_companymasters where fincode = "+insertdata[0] 
	  @data = ActiveRecord::Base.connection.select_all(select_sql)
	  if(@data.length > 0)
		puts "Inside Delete loop"
		delete_sql = "Delete from mf_companymasters where fincode = "+insertdata[0]
		@del_data = ActiveRecord::Base.connection.delete(delete_sql)
	  end
      mfc.fincode = insertdata[0]
      mfc.scripcode = insertdata[1]
      mfc.symbol = insertdata[2]
      mfc.compname = insertdata[3]
      mfc.s_name = insertdata[4]
      mfc.ind_code = insertdata[5]
      mfc.ind_name = insertdata[6]
      mfc.isin = insertdata[7]
      mfc.status = insertdata[8]
	  mfc.category = insertdata[9]
      mfc.upd_flag = insertdata[10]
      mfc.save
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
