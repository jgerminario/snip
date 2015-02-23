module SearchDisplay

	extend self

	def check_for_title(line)
		line.match(/\*\*\*\* Snippet \d+:/)
	end

	def return_search_results(file,text=nil,ext=nil)
    search_results = search_snips(divide_snips(file), text, ext)
		if search_results.any?
			 search_results
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
    snip_array.shift # todo: check on this
    snip_array
  end

  def search_snips(array,text,ext)
  	array.select do |snip|
      if ext
        includes_ext = (snip.include?("(.#{ext})") || snip.include?(".#{ext}:"))
      else
        includes_ext = true
      end
      # matches either clipboard or normal formatting
      if text
        includes_text = smart_text_search_results?(snip, text)
      else
        includes_text = true
      end
      includes_ext && includes_text
    end
  end

  def smart_text_search_results?(snip, text)
    snip = snip.downcase
    words_arr = text.split(" ")
    words_arr.each do |word|
      unless snip.include?(word.downcase)
        return false
      end
    end
    true
  end

  def delete(file, ids)
  	return_search_results(file).reject do |snip|
  		ids.include?(snip.match(/\*\*\*\* Snippet (\d+):/).captures[0])
  	end
  end
end