# Input ex:
#[#<Snippet:0x007fc98c9cbd20 @code_array=["  def age!\n", "    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5\n", "  end\n"]>, #<Snippet:0x007fc98c9ca678 @code_array=["  def any_oranges?\n", "    !@oranges.empty?\n", "  end\n"]>]


require_relative '../../views/viewformatter'

module DestinationFileWriter

  extend self

  def run(snippet_array)
    # @snip_file_name = @@file_to_open.delete(".rb") + "_snipped.rb"
    # check_config_file_for_file
    # @snip_file_name = "my_snips.rb"
    # create_new_file
    write_file(snippet_array)
  end  

  def check_config_file_for_snip_file
    if snip_filepath
      check_if_file_still_exists
    else
      abort("Please specify where you would like to save your snippet file by running 'snip -f <filepath>'")
      # input = $stdin.gets.chomp
      # @file_name = File.absolute_path(input)
      # save_file_path_to_config_file
    end
  end 

  def snip_filepath
    File.readlines("config/filepath.config")[0]
  end

  def check_if_file_still_exists
    if File.exist?(snip_filepath)
      @snip_file_name = snip_filepath
    else
      abort("Output file not found, please specify existing file location/name or desired location/name for new file by running 'snip -f <filepath>'")
      # @file_name = File.absolute_path(gets.chomp)
      # save_file_path_to_config_file
    end
  end

  def save_file_path_to_config_file(filename)
    File.open("config/filepath.config", "w+") do |f|
      f << File.absolute_path(filename)
    end
    unless File.exist?(filename)
      File.new(filename, 'w')
      abort("New snippet file created at #{File.absolute_path(filename)}")
    end
  end

  # def create_new_file
  #   unless file_exists?
  #     File.new(@snip_file_name, 'w')
  #   end
  # end

  def determine_last_index
    1
  end


  def write_file(snippet_array)
    File.open(@snip_file_name, "a") do |file|
      snippet_array.each_with_index do |snip_object, index|
        file << ViewFormatter.snippet_indexer(determine_last_index+index, snip_object.title)
        file << ViewFormatter.status_line(snip_object.line)
        file << "\n"
        file << snip_object.code
        file << "\n\n"
      end
    end
  end

  def full_file_directory
    File.absolute_path(@snip_file_name)
  end

end
