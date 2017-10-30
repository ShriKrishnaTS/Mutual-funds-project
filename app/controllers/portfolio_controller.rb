class PortfolioController < ApplicationController

  def read_portfolio

	Thread.new do
			portfolio_data()
		end
   

  end

  def portfolio_data
  
	 @last_index = 0
    @result = 1
    @logfile = "mf_portfolio"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mf_portfolio.ace","r")
      if afile
        @fileavbl = "File available"
        @count = File.foreach(afile).inject(0) {|c, line| c+1}
        @i=0
		add_line=''
        afile.each { |line|
		if line.to_s.strip.length == 0
			puts "Line No : " + @i.to_s + "---- is Empty line" 
		elsif line.to_s.strip.length < 8
			puts "Inside else part"
			line = add_line
			@last_index == 1
		else
			puts "Line No : " + @i.to_s + "----" + line
			line = line.rstrip
			line_last_chars = line[-8,8]
			puts "Last char of line : " + line_last_chars
			if @last_index == 1
				line = add_line + line
				puts "Added Line : " + line
				add_line = ' '
				@last_index = 0
			end
			if line_last_chars == '<</row>>'
				#puts "Inside Last chars loop"
				#puts "Line No : " + @i.to_s + "---- is fine ----" + line
				#puts "proceed for split"
				#puts line
				if ! line.valid_encoding?
					line = line.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
				end
					@i = @i+1
					@total_records = @total_records + 1
					@tokens = line.split("<<row>>")
					#puts "row split done"
					@first_splt_result = @tokens[1].split("<</row>>")
					#puts "end tag split done"
					@final_split = @first_splt_result[0].split("|")
					puts "splitter done"
					@result = 1
					insert_portfolio(@final_split)
					if (@result == 0)
						@insert_count = @insert_count + 1
						puts @insert_count
					else
						@uninsert_count = @uninsert_count + 1
						puts @uninsert_count
					end
			else
				puts "Inside else part of Last chars loop"
				add_line = line
				puts "Lines without end row tag : " + add_line
				@last_index = 1
			end
		end
        @i = @i + 1
	    }
		messages = "Total Records as per File : " + @total_records.to_s
        messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
        messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
        lc.writelog(messages,@logfile)
      else
        @fileavbl = "File Not Available"
      end
    rescue =>err
	puts err.message
	  lc.writelog(err.message,@logfile)
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,@logfile)
    end

  end
  
  def insert_portfolio(insertdata)

    begin
		#puts "inside insert fn"
      lc = LogcreatorController.new
      pf = MfPortfolio.new
      pf.schemecode = insertdata[0]

      if insertdata[1].blank?
        pf.invdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        pf.invdate = DateTime.strptime(insertdata[1],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      if insertdata[2].blank?
        pf.invenddate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        pf.invenddate = DateTime.strptime(insertdata[2],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      pf.srno = insertdata[3]
      pf.fincode = insertdata[4]
      pf.asect_code = insertdata[5]
      pf.sect_code = insertdata[6]
      pf.noshares = insertdata[7]
      pf.mktval = insertdata[8]
      pf.aum = insertdata[9]
      pf.holdpercentage = insertdata[10]
	  #puts insertdata[11]
      pf.compname = insertdata[11]
      pf.sect_name = insertdata[12]
      pf.asect_name = insertdata[13]
      pf.rating = insertdata[14]
      pf.upd_flag = insertdata[15]
      pf.save
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
