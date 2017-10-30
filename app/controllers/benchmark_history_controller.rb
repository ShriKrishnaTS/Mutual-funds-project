class BenchmarkHistoryController < ApplicationController

  def read_bm_indices
   
	Thread.new do
			benchmark_history()
		end

  end

  def benchmark_history
	@result = 1
    @logfile = "bm_indices_return"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/bm_indices_return.ace","r")
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
            insert_bm_Ind(@final_split)
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
  
  def insert_bm_Ind(insertdata)

    begin
      lc = LogcreatorController.new
      bmf = BmIndicesRe.new
      bmf.index_code = insertdata[0]
      if insertdata[1].blank?
        puts "Date value is Empty"
        bmf.date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.date = DateTime.strptime(insertdata[1].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.dayret_1 = insertdata[2]
      if insertdata[3].blank?
        puts "Date value is Empty"
        bmf.weekdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.weekdate_1 = DateTime.strptime(insertdata[3].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.weekclose_1 = insertdata[4]
      bmf.weekret_1 = insertdata[5]
      if insertdata[6].blank?
        puts "Date value is Empty"
        bmf.mthdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.mthdate_1 = DateTime.strptime(insertdata[6].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.mthclose_1 = insertdata[7]
      bmf.monthret_1 = insertdata[8]
      if insertdata[9].blank?
        puts "Date value is Empty"
        bmf.mthdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.mthdate_3 = DateTime.strptime(insertdata[9].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.mthclose_3 = insertdata[10]
      bmf.monthret_3 = insertdata[11]
      if insertdata[12].blank?
        puts "Date value is Empty"
        bmf.mthdate_6 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.mthdate_6 = DateTime.strptime(insertdata[12].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.mthclose_6 = insertdata[13]
      bmf.monthret_6 = insertdata[14]
      if insertdata[15].blank?
        puts "Date value is Empty"
        bmf.mthdate_9 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.mthdate_9 = DateTime.strptime(insertdata[15].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.mthclose_9 = insertdata[16]
      bmf.monthret_9 = insertdata[17]
      if insertdata[18].blank?
        puts "Date value is Empty"
        bmf.yrdate_1 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.yrdate_1 = DateTime.strptime(insertdata[18].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.yrclose_1 = insertdata[19]
      bmf.yrret_1 = insertdata[20]
      if insertdata[21].blank?
        puts "Date value is Empty"
        bmf.yrdate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.yrdate_2 = DateTime.strptime(insertdata[21].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.yrclose_2 = insertdata[22]
      bmf.yrret_2 = insertdata[23]
      if insertdata[24].blank?
        puts "Date value is Empty"
        bmf.yrdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.yrdate_3 = DateTime.strptime(insertdata[24].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.yrclose_3 = insertdata[25]
      bmf.yrret_3 = insertdata[26]
      if insertdata[27].blank?
        puts "Date value is Empty"
        bmf.yrdate_4 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.yrdate_4 = DateTime.strptime(insertdata[27].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.yrclose_4 = insertdata[28]
      bmf.yrret_4 = insertdata[29]
      if insertdata[30].blank?
        puts "Date value is Empty"
        bmf.yrdate_5 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.yrdate_5 = DateTime.strptime(insertdata[30].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.yrclose_5 = insertdata[31]
      bmf.yrret_5 = insertdata[32]
      if insertdata[33].blank?
        puts "Date value is Empty"
        bmf.incdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.incdate = DateTime.strptime(insertdata[33].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.incclose = insertdata[34]
      bmf.incret = insertdata[35]
      if insertdata[36].blank?
        puts "Date value is Empty"
        bmf.weekdate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.weekdate_2 = DateTime.strptime(insertdata[36].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.weeknav_2 = insertdata[37]
      bmf.weekret_2 = insertdata[38]
      if insertdata[39].blank?
        puts "Date value is Empty"
        bmf.weekdate_3 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.weekdate_3 = DateTime.strptime(insertdata[39].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.weeknav_3 = insertdata[40]
      bmf.weekret_3 = insertdata[41]
      if insertdata[42].blank?
        puts "Date value is Empty"
        bmf.mthdate_2 = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        bmf.mthdate_2 = DateTime.strptime(insertdata[42].from(0).to(-5),"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      end
      bmf.mthnav_2 = insertdata[43]
      bmf.monthret_2 = insertdata[44]
      bmf.ytddate = insertdata[45]
      bmf.ytdnav = insertdata[46]
      bmf.ytdret = insertdata[47]
      bmf.upd_flag = insertdata[48]
      bmf.save
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
