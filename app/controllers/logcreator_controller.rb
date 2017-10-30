class LogcreatorController < ApplicationController

  def createlogfile(logfile)
    begin
      dirdte = Time.now.strftime("%Y%m%d")
      dir = File.dirname("#{Rails.root}/log/")
      dirname =  dir + "/log/" + dirdte
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
      filename = dirname + "/" + logfile + ".log"
      if (File.exist?(filename))

      else
        afile = File.new(filename, "w")
        afile.close
      end
    rescue =>err
      lfile = File.open(filename,"a")
      lfile.syswrite(err.message)
      lfile.syswrite("\n");
      lfile.close
      puts err.message
    end
    return filename
  end

  def writelog(logmsg,logfile)
    begin
      dirdte = Time.now.strftime("%Y%m%d")
      dir = File.dirname("#{Rails.root}/log/")
      dirname =  dir + "/log/" + dirdte
      filename = dirname + "/" + logfile +".log"
      lfile = File.open(filename,"a")
      lfile.syswrite("\n");
      lfile.syswrite(logmsg)
      lfile.syswrite("\n");
      lfile.close
    end
  end
end
