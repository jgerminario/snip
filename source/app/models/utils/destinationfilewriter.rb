# Input ex:
#[#<Snippet:0x007fc98c9cbd20 @code_array=["  def age!\n", "    @oranges += Array.new(rand(1..10)) { Orange.new } if @age > 5\n", "  end\n"]>, #<Snippet:0x007fc98c9ca678 @code_array=["  def any_oranges?\n", "    !@oranges.empty?\n", "  end\n"]>]


require_relative '../../views/viewformatter'
CONFIG_PATH = File.expand_path("../../../../config/filepath.config", __FILE__)
LOG_PATH = File.expand_path("../../../../log/snip.log", __FILE__)

module DestinationFileWriter

  extend self

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
      abort(ViewFormatter.output_file_not_found(snip_file))
    end
  end

  def run(snippet_array, type=nil)
    directory = File.dirname(@snip_file_name)
    case type
    when "rb"
      filename = directory + "/my_snips.rb"
      File.new(filename, 'w') unless File.exist?(filename)
    when "js"
      filename = directory + "/my_snips.js"
      File.new(filename, 'w') unless File.exist?(filename)
    else
      filename = @snip_file_name
    end
    write_file(snippet_array, filename, type)
  end  


  def save_file_path_to_config_file(filedir)
    snip_file = File.absolute_path(filedir).chomp('/') + "/my_snips.txt"
    File.open(CONFIG_PATH, "w+") do |f|
      f << snip_file
    end
    unless File.exist?(snip_file)
      File.new(snip_file, 'w')
      abort(ViewFormatter.new_file(snip_file))
    end
  end

  def determine_next_index(filename)
    last_snip_scan = File.readlines(filename).reverse.join
    if last_snip_scan.match(/\*\*\*\* Snippet (\d+):/)
      last_snip_scan.match(/\*\*\*\* Snippet (\d+):/).captures[0].to_i+1
    else
      1
    end
  end

  def write_file(snippet_array, filename, type)
    File.open(filename, "a") do |file|
      snippet_array.each_with_index do |snip_object, index|
        file << ViewFormatter.snippet_indexer(determine_next_index(filename)+index, snip_object.title, type)
        file << ViewFormatter.status_line(snip_object.line, type)
        file << "\n"
        file << snip_object.code
        file << "\n\n"
        unless type 
          log = ViewFormatter.snip_terminal_status(snip_object.filename, snip_object.line)
          puts log
          write_to_log_file(log)
        end
      end
    end
  end

  def write_to_log_file(log)
    File.open(LOG_PATH, "a") do |file|
      file << Time.now.strftime("%m-%d-%Y").to_s + " " + log + "\n"
    end
  end

  def full_file_directory
    File.absolute_path(@snip_file_name)
  end

  def log_filepath
    LOG_PATH
  end

end
