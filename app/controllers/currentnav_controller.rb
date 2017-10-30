class CurrentnavController < ApplicationController

  def read_currentnav
    Thread.new do
		currentnav_data()
	end
  end
  
  def currentnav_data
	@result = 1
    @logfile = "currentnav"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    afile = File.open("app/assets/files/currentnav.ace","r")
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
            insert_currentnav(@final_split)
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

    rescue => e
      lc.writelog(e.message,@logfile)
      messages = "Total Records as per File : " + @total_records.to_s
      messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
      messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
      lc.writelog(messages,"currentnav")
    end

  end

  def insert_currentnav(insertdata)
    begin
      lc = LogcreatorController.new
      cn = Currentnav.new
      cn.schemecode = insertdata[0]
      if insertdata[1].blank?
        cn.navdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        #cn.navdate = DateTime.strptime(insertdata[1].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
		cn.navdate = DateTime.strptime(insertdata[1],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db) #dat format changed
      end
      cn.navrs = insertdata[2]
      cn.repurprice = insertdata[3]
      cn.saleprice = insertdata[4]
      if insertdata[5].empty?
        cn.cldate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        #cn.cldate = DateTime.strptime(insertdata[5].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
		cn.cldate = DateTime.strptime(insertdata[5],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end
      cn.change = insertdata[6]
      cn.netchange = insertdata[7]
      cn.prevnav = insertdata[8]
      if insertdata[9].empty?
        cn.prenavdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        #cn.prenavdate = DateTime.strptime(insertdata[9].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
		cn.prenavdate = DateTime.strptime(insertdata[9],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end
      cn.upd_flag = insertdata[10]
      cn.save
      @result = 0
    end
    rescue => err
      puts  err.message
      lc.writelog(err.message,@logfile)
      errmsg = insertdata[0] + " Not Inserted"
      lc.writelog(errmsg,@logfile)
      @result = 1

    end

end
