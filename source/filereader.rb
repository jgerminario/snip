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