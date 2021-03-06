class RegMstController < ApplicationController

  def read_registrar_mst
    Thread.new do
			registrar_master()
		end

  end

  def registrar_master
	@result = 1
    @logfile = "rt_mst"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/rt_mst.ace","r")
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
            @result=1
            insert_registrar_mst(@final_split)
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
  
  def insert_registrar_mst(insertdata)
    begin
      lc = LogcreatorController.new
      rm = RtMst.new
	  select_sql = "select * from rt_msts where rt_code = "+insertdata[0] 
	  @data = ActiveRecord::Base.connection.select_all(select_sql)
	  if(@data.length > 0)
		puts "Inside Delete loop"
		delete_sql = "Delete from rt_msts where rt_code = "+insertdata[0]
		@del_data = ActiveRecord::Base.connection.delete(delete_sql)
	  end
      rm.rt_code = insertdata[0]
      rm.rt_name = insertdata[1]
      rm.sebi_reg_no = insertdata[2]
      rm.address1 = insertdata[3]
      rm.address2 = insertdata[4]
      rm.address3 = insertdata[5]
      rm.state = insertdata[6]
      rm.tel = insertdata[7]
      rm.fax = insertdata[8]
      rm.website = insertdata[9]
      rm.reg_address = insertdata[10]
      rm.email = insertdata[11]
      rm.upd_flag = insertdata[12]
      rm.save
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
