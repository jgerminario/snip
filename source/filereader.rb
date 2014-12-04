# Input ex.
# #<snip>
#   def age!
#     @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5
#   end
# #</snip>

# #<snip>
#   def any_oranges?
#     !@oranges.empty?
#   end
# #</snip>

class FileReaderWriter
attr_reader :file_to_open

  def initialize(file_to_open)
    @@file_to_open = file_to_open
    @array_of_lines = []
    @overwrite = []
  end

  def convert_to_array_of_lines
    File.open(@@file_to_open, "r").each do |line|
      @array_of_lines << line
    end
    @array_of_lines
  end

  def overwrite_existing_snips
    File.open(@@file_to_open, "r+").each do |line|
      @overwrite << line
      end
      overwrite
      rewrite_whole_file
    end

  def overwrite
    @overwrite.each_with_index do |element, index|
      if element.include?("#<snip>")
        @overwrite[index] = "#<*snip*>\n"
      end
      if element.include?("#</snip>")
        @overwrite[index] = "#<*snip*>\n"
      end
    end
  end

  def rewrite_whole_file
    File.open(@@file_to_open, "w") do |file|
      @overwrite.each do |line|
        file << line
      end
    end
  end

end