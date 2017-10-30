class ReadamcmstController < ApplicationController
  require 'fileutils'
	def messages
		@message = "Hello, how are you today?"

		aFile = File.new("app/assets/files/input.txt", "w")
		if aFile
		  aFile.syswrite("ABCDEF")
		else
		  puts "Unable to open file!"
		end
	end

	def read_amc_mst
		 Thread.new do
			amc_mst()
		end
	end
 
	def amc_mst
		begin
		  lc = LogcreatorController.new
		  lc.createlogfile("amc_mst")
		  afile = File.open("app/assets/files/amc_mst.ace","r")
		  if afile
			@fileavbl = "File available"
			@count = File.foreach(afile).inject(0) {|c, line| c+1}
			@insert_count = 0
			@uninsert_count = 0
			@total_records = 0
			@delete_count = 0
			afile.each { |line|
			  begin
				if line == "<<eof>>"
				  @endoffile = "Transfer done"
				else
				  @total_records = @total_records + 1
				  @tokens = line.split("<<row>>")
				  @first_splt_result = @tokens[1].split("<</row>>")
				  @final_split = @first_splt_result[0].split("|")
				  select_sql = "select * from amc_msts where amc_code = "+@final_split[0].to_s 
				  @data = ActiveRecord::Base.connection.select_all(select_sql)
				  if(@data.length > 0)
					puts "Inside Delete loop"
					@delete_count = @delete_count + 1
					delete_sql = "Delete from amc_msts where amc_code = "+@final_split[0].to_s 
					@del_data = ActiveRecord::Base.connection.delete(delete_sql)
				  end
				  amc = AmcMst.new
				  amc.amc_code = @final_split[0]
				  amc.amc = @final_split[1]
				  amc.fund = @final_split[2]
				  amc.srno = @final_split[3]
				  amc.office_type = @final_split[4]
				  amc.add1 = @final_split[5]
				  amc.add2 = @final_split[6]
				  amc.add3 = @final_split[7]
				  amc.email = @final_split[8]
				  amc.phone = @final_split[9]
				  amc.fax = @final_split[10]
				  amc.website = @final_split[11]
				  if @final_split[12].blank?
					amc.setup_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %I:%M:%S").to_formatted_s(:db)
				  else
					amc.setup_date = DateTime.strptime(@final_split[12],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
				  end
				  amc.mf_type = @final_split[13]
				  amc.trustee_name = @final_split[14]
				  amc.sponsor_name = @final_split[15]
				  if @final_split[16].blank?
					amc.amc_inc_date = DateTime.strptime('0001-01-01 00:00:00',"%Y-%m-%d %I:%M:%S").to_formatted_s(:db)
				  else
					amc.amc_inc_date = DateTime.strptime(@final_split[16],"%m/%d/%Y %I:%M:%S %p").to_formatted_s(:db)
				  end
				  amc.upd_flag = @final_split[17]
				  amc.save
				  @insert_count = @insert_count + 1
				end

			  rescue =>err
				# handle everything else
				@uninsert_count = @uninsert_count + 1
				puts  err.message
				lc.writelog(err.message,"amc_mst")
				errmsg = @final_split[0] + " Not Inserted"
				lc.writelog(errmsg,"amc_mst")
				next
			  ensure

			  end
			}
			messages = "Total Records as per File : " + @total_records.to_s
			messages = messages + "\n" + "Total Records Inserted : " + @insert_count.to_s
			messages = messages + "\n" + "Total Records Not Inserted : "+@uninsert_count.to_s
			messages = messages + "\n" + "Total Records Updated : "+@delete_count.to_s
			lc.writelog(messages,"amc_mst")
		  else
			@fileavbl = "File Not Available"
		  end

		rescue => e# StandardError
		  lc.writelog(e.message,"amc_mst")
		end
	end 
end
