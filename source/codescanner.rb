# Input ex ("\n" and whitespace are necessary to keep to preserve formatting):
#["#<snip>\n", "  def age!\n", "    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5\n", "  end\n", "#</snip>\n", "\n", "#<snip>\n", "  def any_oranges?\n", "    !@oranges.empty?\n", "  end\n", "#</snip>\n", "\n"]


class Snippet
  @@snippet_array = []
  attr_reader :code_array, :title, :line

  def initialize(code_array, title, line)
    @code_array = code_array
    @title = title
    @@snippet_array << self
    @line = line
  end

  def self.snippet_array
    @@snippet_array
  end
end

class CodeScanner
  @scan_array = []
  class << self; attr_reader :scan_array end
  def self.run(scan_array)
    @scan_array = scan_array
    while @scan_array.join.include?('<snip>')
      Snippet.new(array_range, @title, @line)
    end
  end

  def self.find_begin_range
    @scan_array.each_with_index do |line, index|
      if line.include?('<snip>')
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
      if line.include?('</snip>')
        strip_snip_tag(index)
        return @end_scan = index
      end
    end
    return false
  end

   def self.array_range
    find_begin_range
    find_end_range
    @scan_array[@begin_scan+1..@end_scan-1]
  end

  def self.strip_snip_tag(index)
    @scan_array
    @scan_array[index].sub!(/<snip>/,'<*snip*>') ## WTF - returns an array stripped of all <snip> tags
    @scan_array
    @scan_array[index].sub!(/<\/snip>/,'</*snip*>')
  end

  def self.find_title(index)
    matches = @scan_array[index].match(/<snip>(.+)/)
    if matches
      @title = matches[1].strip
    end
    @title
  end
end
