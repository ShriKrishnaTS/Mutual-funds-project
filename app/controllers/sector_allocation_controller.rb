class SectorAllocationController < ApplicationController

  def read_sector_allocation
   Thread.new do
			sector_allocation()
		end

  end

  def sector_allocation
  
    @result = 1
    @logfile = "sect_allocation"
    @insert_count = 0
    @uninsert_count = 0
    @total_records = 0
    lc = LogcreatorController.new
    lc.createlogfile(@logfile)
    begin
      afile = File.open("app/assets/files/sect_allocation.ace","r")
      if afile
        @fileavbl = "File available"
        @count = File.foreach(afile).inject(0) {|c, line| c+1}
        @i=0
        afile.each { |line|
          puts line
          if line == '<<eof>>'
            @endoffile = "Transfer done"
            afile.close
          else
            @i = @i+1
            @total_records = @total_records + 1
            @tokens = line.split("<<row>>")
            @first_splt_result = @tokens[1].split("<</row>>")
            @final_split = @first_splt_result[0].split("|")
            @result = 1
            insert_sector_allocation(@final_split)
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
  
  def insert_sector_allocation(insertdata)

    begin
      lc = LogcreatorController.new
      sca = SectAllocation.new
      sca.amc_code = insertdata[0]
      sca.schemecode = insertdata[1]
      if insertdata[2].blank?
        sca.invdate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sca.invdate = DateTime.strptime(insertdata[2],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end
      if insertdata[3].blank?
        sca.invenddate = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %H:%M:%S").to_formatted_s(:db)
      else
        sca.invenddate = DateTime.strptime(insertdata[3],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
      end

      sca.srno = insertdata[4]
      sca.sect_code = insertdata[5]
      sca.sect_name = insertdata[6]
      sca.asect_code = insertdata[7]
      sca.perc_hold = insertdata[8]
      sca.value = insertdata[9]
      sca.aum = insertdata[10]
      sca.upd_flag = insertdata[11]
      sca.save
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
