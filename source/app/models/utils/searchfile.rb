module SearchDisplay

	extend self

	def check_for_title(line)
		line.match(/\*\*\*\* Snippet \d+:/)
	end

	def run(file,text="",ext="")
		if !search_snips(divide_snips(file), text, ext).empty?
			 search_snips(divide_snips(file), text, ext)
		else
			ViewFormatter.no_results
		end
	end

  def divide_snips(file)
  	snip_array = []
  	snip_str = ""
    File.open(file, "r").each do |line|
    	if check_for_title(line)
	      snip_array << snip_str
	    	snip_str = line
	    else
	      snip_str << line
	    end
    end
    snip_array << snip_str
    snip_array.shift
    snip_array
  end

  def search_snips(array,text,ext)
  	array.select{ |snip| snip.include?(text) && snip.include?(ext)}
  end

  def delete(file, ids)
  	run(file).reject do |snip|
  		ids.include?(snip.match(/\*\*\*\* Snippet (\d+):/).captures[0])
  	end
  end
end