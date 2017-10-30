class RupeevestRatingsController < ApplicationController

	def read_rupeevest_rating
		Thread.new do
			rupeevest_rating()
		end
    end
	
	def rupeevest_rating
	
	@result = 1
	@logfile = "rating"
	@insert_count = 0
	@uninsert_count = 0
	@total_records = 0
	lc = LogcreatorController.new
	lc.createlogfile(@logfile)
	begin
		afile = File.open("app/assets/files/rating.csv","r")
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
					@final_split = line.split(",")
					@result = 1
					if @final_split[0] == "schemecode"
						puts "header line no need to insert"
					else
						insert_rupeevest_rating(@final_split)
						if(@result == 0)
							@insert_count = @insert_count + 1
							puts @insert_count
						else
							@uninsert_count = @uninsert_count + 1
							puts @uninsert_count
						end
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
	

  def insert_rupeevest_rating(insertdata)

	    begin
	      lc = LogcreatorController.new
	      rr = RupeevestRating.new
	      rr.schemecode = insertdata[0]
	      rr.total_return = insertdata[1]
	      rr.consistency_of_return = insertdata[2]
	      rr.risk = insertdata[3]
	      rr.cost_factor = insertdata[4]
	      rr.portfolio_attributes = insertdata[5]
	      rr.rupeevest_rating	 = insertdata[6]


	      rr.save
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
