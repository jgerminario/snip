# Input ex:
#[#<Snippet:0x007fc98c9cbd20 @code_array=["  def age!\n", "    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5\n", "  end\n"]>, #<Snippet:0x007fc98c9ca678 @code_array=["  def any_oranges?\n", "    !@oranges.empty?\n", "  end\n"]>]


require_relative '../../views/viewformatter'
CONFIG_PATH = File.expand_path("../../../../config/filepath.config", __FILE__)

module DestinationFileWriter

  extend self

  def run(snippet_array)
    write_file(snippet_array)
  end  

  def check_config_file_for_snip_file
    if snip_filepath
      check_if_file_still_exists
    else
      abort(ViewFormatter.specify_path)
    end
  end 

  def snip_filepath
    File.readlines(CONFIG_PATH)[0]
  end

  def check_if_file_still_exists
    if File.exist?(snip_filepath)
      @snip_file_name = snip_filepath
    else
      abort(ViewFormatter.output_file_not_found)
    end
  end

  def save_file_path_to_config_file(filename)
    File.open(CONFIG_PATH, "w+") do |f|
      f << File.absolute_path(filename)
    end
    unless File.exist?(filename)
      File.new(filename, 'w')
      abort(ViewFormatter.new_file(filename))
    end
  end

  def determine_next_index
    last_snip_scan = File.readlines(@snip_file_name).reverse.join
    if last_snip_scan.match(/\*\*\*\* Snippet (\d+):/)
      last_snip_scan.match(/\*\*\*\* Snippet (\d+):/).captures[0].to_i+1
    else
      1
    end
  end


  def write_file(snippet_array)
    File.open(@snip_file_name, "a") do |file|
      snippet_array.each_with_index do |snip_object, index|
        file << ViewFormatter.snippet_indexer(determine_next_index+index, snip_object.title)
        file << ViewFormatter.status_line(snip_object.line)
        file << "\n"
        file << snip_object.code
        file << "\n\n"
        puts ViewFormatter.snip_terminal_status(snip_object.filename, snip_object.line)
      end
    end
  end

  def full_file_directory
    File.absolute_path(@snip_file_name)
  end

end
