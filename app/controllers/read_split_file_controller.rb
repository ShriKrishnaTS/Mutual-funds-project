class ReadSplitFileController < ApplicationController

  def read_asset_alloc_mast(strFileName)
    afile = File.open("app/assets/files/"+strFileName,"r")
    if afile
      @fileavbl = "File available"
    else
      @fileavbl = "File Not Available"
    end
    @count = File.foreach(afile).inject(0) {|c, line| c+1}
    @i=0
    afile.each { |line|
      puts line
      if line == '<<eof>>'
        @endoffile = "Transfer done"
      else
        @i = @i+1
        @tokens = line.split("<<row>>")
        @first_splt_result = @tokens[1].split("<</row>>")
        final_split = @first_splt_result[0].split("|")
        return final_split
      end
    }
  end
end
