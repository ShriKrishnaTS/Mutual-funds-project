class NavHistoryController < ApplicationController

  def read_nav_history
    Thread.new do
			nav_history()
		end


  end
	
	def nav_history
	
		@result = 1
		@logfile = "navhistfull"
		@insert_count = 0
		@uninsert_count = 0
		@total_records = 0
		lc = LogcreatorController.new
		lc.createlogfile(@logfile)
		begin
		  afile = File.open("app/assets/files/navhistfull.ace","r")
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
				insert_nav_his(@final_split)
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
  def insert_nav_his(insertdata)
    begin
      lc = LogcreatorController.new
      nh = Navhistfull.new
      nh.schemecode = insertdata[0]
      puts insertdata[0]
      if insertdata[1].empty?
        nh.navdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        nh.navdate = DateTime.strptime(insertdata[1].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end

      nh.navrs = insertdata[2]
      nh.repurprice = insertdata[3]
      nh.saleprice = insertdata[4]
      nh.adjustednav_c = insertdata[5]
      nh.adjustednav_nonc = insertdata[6]
      nh.upd_flag = insertdata[7]
      nh.save
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
