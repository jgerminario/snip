# Input ex ("\n" and whitespace are necessary to keep to preserve formatting):
#["#<snip>\n", "  def age!\n", "    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5\n", "  end\n", "#</snip>\n", "\n", "#<snip>\n", "  def any_oranges?\n", "    !@oranges.empty?\n", "  end\n", "#</snip>\n", "\n"]

require_relative "../snippet"

class CodeScanner
  @scan_array = []
  class << self; attr_reader :scan_array end
  def self.run(scan_array, filename)
    @scan_array = scan_array
    while @scan_array.join.include?('<snip>') || @scan_array.join.include?('<$>')
      code = array_range
      if code
        Snippet.new(code: code, title: @title, line: @line, filename: filename)
      else
        return {filename: filename, line: @line} #in case of mismatch
      end
    end
    return nil
  end

  def self.find_begin_range
    @scan_array.each_with_index do |line, index|
      if line.include?('<snip>') || line.include?('<$>')
        find_title(index)
        @line = index+1
        strip_snip_tag(index)
        return @begin_scan = index
      end
    end
    return false
  end

  def self.find_end_range
    @scan_array.each_with_index do |line, index|
      if line.include?('<snip>') || line.include?('<$>') #mismatch before closing tag
        return false
      end
      if line.include?('</snip>') || line.include?('</$>')
        strip_snip_tag(index)
        index
        return @end_scan = index
      end
    end
    return false
  end

  def self.array_range
    find_begin_range
    return false unless find_end_range
    @scan_array[@begin_scan+1..@end_scan-1].join
  end

  def self.strip_snip_tag(index)
    @scan_array[index].sub!(/<snip>/,'<*snip*>')
    @scan_array[index].sub!(/<\/snip>/,'</*snip*>')
    @scan_array[index].sub!(/<\$>/,'<*$*>')
    @scan_array[index].sub!(/<\/\$>/,'</*$*>')
  end

  def self.find_title(index)
    matches = @scan_array[index].match(/(<snip>|<\$>)(.+)/)
    if matches
      @title = matches[2].strip.chomp('-->')
    end
    @title
  end
end
