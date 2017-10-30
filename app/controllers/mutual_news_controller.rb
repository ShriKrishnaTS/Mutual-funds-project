class MutualNewsController < ApplicationController
  def read_mutual_news
    @result = 1
    @logfile = "mfinews_2012031501"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/mfinews_2012031001.ace","r")
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
            insert_mutual_new(@final_split)
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

  def insert_mutual_new(insertdata)
    begin
      lc = LogcreatorController.new
      mfn = MfiNews.new
      puts "hi"
      mfn.news_id = insertdata[0]
      mfn.section_name = insertdata[1]
      mfn.subsection_name = insertdata[2]
      mfn.date = DateTime.strptime(insertdata[3],"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      mfn.time = insertdata[4]
      mfn.headline = insertdata[5]
      mfn.summary = insertdata[6]
	  details_news = insertdata[7].gsub(/<P align=justify>/,"")
	  details_news = details_news.gsub(/<P>/,"")
	  details_news = details_news.gsub(/&nbsp;/,"")
	  details_news = details_news.gsub(/<BR>/,"")
	  puts details_news
	  mfn.details_news = details_news
      mfn.amccode = insertdata[8]
      mfn.schemecode = insertdata[9]
      mfn.upd_flag = insertdata[11]
      mfn.save
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
