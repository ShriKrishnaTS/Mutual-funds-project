class FtpdownloaderController < ApplicationController

  def filesdownloader
    require 'rubygems'
    require 'net/ftp'
    require 'fileutils'

    ftpurl = 'ftpservice.acesphere.com'
    username = 'rupeevest'
    passwd = 'Rup$02F16'
    filename = 'divdetails.ace'
    directory = '/mutualfund/11082016/'
    localfile = '/vagrant/rails/rupeevest/1.ace'
    #ftp=Net::FTP.new
    Net::FTP.open(ftpurl) do |ftp|
      ftp.debug_mode = true
      #ftp.passive = true
      ftp.connect(ftpurl,21)
      if ftp.login(username,passwd)
        puts("FTP Connected")
      else
        puts("FTP Not Connected")
      end
     ftp.chdir(directory)
      puts("Directory Available in FTP")
      @files =  Dir.entries('/root/mutualfund/11082016/')
      for file in @files
        puts file
      end
      if File.exist?('divdetails.ace')
        puts "File Availabe"
     else
       puts "File Not Available"
     end

     # ftp.getbinaryfile(filename,localfile,1024)
      ftp.close
    end
  rescue Exception => msg
    puts msg
  end
end
