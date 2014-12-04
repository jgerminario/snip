# Input ex:
#[#<Snippet:0x007fc98c9cbd20 @code_array=["  def age!\n", "    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5\n", "  end\n"]>, #<Snippet:0x007fc98c9ca678 @code_array=["  def any_oranges?\n", "    !@oranges.empty?\n", "  end\n"]>]


require_relative 'viewformatter'

module DestinationFileWriter

  extend self

  def run(snippet_array)
    # @new_file_name = @@file_to_open.delete(".rb") + "_snipped.rb"
    @new_file_name = "my_snips.rb"
    file_exists?
    create_new_file
    write_file(snippet_array)
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

  def write_file(snippet_array)
    File.open(@new_file_name, "a") do |file|
      snippet_array.each_with_index do |snip_object, index|
        file << ViewFormatter.snippet_indexer(index, snip_object.title)
        snip_object.code_array.each do |line|
          file << line
        end
        file << ViewFormatter.status_line(snip_object.line)
        file << "\n\n"
      end
    end
  end

  def full_file_directory
    File.absolute_path(@new_file_name)
  end

end
