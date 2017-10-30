class SchemeObjController < ApplicationController

  def read_scheme_obj
	Thread.new do
			scheme_object()
		end
  end

  def scheme_object
	 @last_index = 0
    @result = 1
    @logfile = "scheme_objective"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/scheme_objective.ace","r")
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
			#puts "Line No : " + @i.to_s + "----" + line
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
				puts "proceed for split"
					@i = @i+1
					@total_records = @total_records + 1
					@tokens = line.split("<<row>>")
					@first_splt_result = @tokens[1].split("<</row>>")
					@final_split = @first_splt_result[0].split("|")
					@result = 1
					insert_scheme_obj(@final_split)
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
	  lc.writelog(err.message,@logfile)
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,@logfile)
    end
  end
  def insert_scheme_obj(insertdata)
    begin
      lc = LogcreatorController.new
      sob = SchemeObjective.new
	  select_sql = "select * from scheme_objectives where schemecode = "+insertdata[0] 
	  @data = ActiveRecord::Base.connection.select_all(select_sql)
	  if(@data.length > 0)
		puts "Inside Delete loop"
		delete_sql = "Delete from scheme_objectives where schemecode = "+insertdata[0]
		@del_data = ActiveRecord::Base.connection.delete(delete_sql)
	  end
      sob.schemecode = insertdata[0]
      sob.objective = insertdata[1]
      sob.upd_flag = insertdata[2]
      sob.save
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
