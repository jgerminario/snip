require 'debugger'
# file_to_open = ARGV

#["snip.rb", "test.rb"]

class FileReader
attr_reader :file_to_open

  def initialize(file_to_open)
    @@file_to_open = file_to_open
    @array_of_lines = Array.new
  end

  def convert_to_array_of_lines
    File.open(@@file_to_open, "r").each do |line|
      @array_of_lines << line
    end
    @array_of_lines
  end
end


#--------------------Placeholder------------------------
# class Snippet
# attr_reader :code_block

#   def initialize
#     @code_block = ["def initialize
#     @age = 0
#     @height = 1
#     @dead = false
#     @oranges = []
#   end", "def age!
#     @age += 1
#     grow_tree
#     grow_oranges if age == 5
#   end"]
#   end

#   @@snippet_array = [self.new]

#   def self.snippet_array
#     @@snippet_array
#   end

# end
#______________________Placeholder__________________________
class CodeScanner
  @file_array = []
  class << self; attr_reader :file_array end
  def self.run(file_array)
    @file_array = file_array
    while @file_array.include?("#<snip>\n")
     Snippet.new(array_range)
    end
  end

  def self.find_begin_range
    @file_array.each_with_index do |line, index|
      if line == "#<snip>\n"
        strip_snip_tag(index)
        return @begin_scan = index
      end
    end
    return false
  end

  def self.find_end_range
    @file_array.each_with_index do |line, index|
      if line == "#</snip>\n"
        strip_snip_tag(index)
        return @end_scan = index
      end
    end
    return false
  end

   def self.array_range
    find_begin_range
    find_end_range
    @file_array[@begin_scan+1..@end_scan-1]
  end

  def self.strip_snip_tag(index)
    @file_array[index] = ""
  end
end

class Snippet
  @@snippet_array = []
  attr_reader :code_array

  def initialize(code_array)
    @code_array = code_array
    @@snippet_array << self
  end

  def self.snippet_array
    @@snippet_array
  end
end




class FileWriter

  def initialize
    # @new_file_name = @@file_to_open.delete(".rb") + "_snipped.rb"
    @new_file_name = "my_snips.rb"
    file_exists?
    create_new_file
    write_file
  end

  def file_exists?
    dir = Dir.new(".")
    dir.entries.include?(@new_file_name)
  end

  def create_new_file
    unless file_exists?
      File.new(@new_file_name, 'w')
    end
  end

  def write_file
    File.open(@new_file_name, "w") do |file|
      Snippet.snippet_array.each do |snip_object|
        snip_object.code_array.each do |line|
          file << line
        end
      end
    end
  end
end

#Creating new class instances:
file_read = FileReader.new(ARGV.first)
to_run = file_read.convert_to_array_of_lines
p to_run

CodeScanner.run(to_run)
p Snippet.snippet_array

file_write = FileWriter.new

#Tests:
# p file_write.file_exists?
# p file_write.create_new_file
# p file_write.write_file
# p Snippet.snippet_array
