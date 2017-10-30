class CustodianMasterController < ApplicationController


  def read_cust_mast
	Thread.new do
		custodianmaster()
	end
    
  end
  
  def custodianmaster
	@result = 1
    @logfile = "cust_mst"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    puts @logfile.to_s
    lc = LogcreatorController.new
    lc.createlogfile("cust_mst")
    afile = File.open("app/assets/files/cust_mst.ace","r")
    begin
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
            insert_cust_mast(@final_split)
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
        lc.writelog(messages,"cust_mst")
      else
        @fileavbl = "File Not Available"
      end
    rescue => err
      lc.writelog(err.message,"cust_mst")
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,"cust_mst")
    end
  end

  def insert_cust_mast(insertdata)

    begin
      lc = LogcreatorController.new
      cm = CustMst.new
	  select_sql = "select * from cust_msts where cust_code = "+insertdata[0] 
	  @data = ActiveRecord::Base.connection.select_all(select_sql)
	  if(@data.length > 0)
		puts "Inside Delete loop"
		delete_sql = "Delete from cust_msts where cust_code = "+insertdata[0]
		@del_data = ActiveRecord::Base.connection.delete(delete_sql)
	  end
      cm.cust_code = insertdata[0]
      cm.cust_name = insertdata[1]
      cm.sebi_reg_no = insertdata[2]
      cm.add1 = insertdata[3]
      cm.add2 = insertdata[4]
      cm.add3 = insertdata[5]
      cm.upd_flag = insertdata[6]
      cm.save
      @result = 0

    rescue => err
      puts  err.message
      lc.writelog(err.message,"cust_mst")
      errmsg = insertdata[0] + " Not Inserted"
      lc.writelog(errmsg,"cust_mst")
      @result = 1
    end

  end
end
