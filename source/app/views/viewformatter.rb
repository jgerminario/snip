# View component for file writing operations and possibly terminal output
require 'date'

module ViewFormatter

	extend self

	def snippet_indexer(index, title, type)
		if type == "js"
		  "// **** Snippet " + (index).to_s + ": #{title} **** \n"
		elsif type == "erb"
		  "<!-- **** Snippet " + (index).to_s + ": #{title} **** -->\n"
		else
			"# **** Snippet " + (index).to_s + ": #{title} **** \n"
		end
	end

	def file_not_found
		"File not found, please try again."
	end

	def invalid_file
		"File must be a .js, .rb or .erb file."
	end

	def success_message(filedir)
		if Snippet.snippet_counter > 0
			"Your snippet file has been successfully updated with #{Snippet.snippet_counter} new snips at: '#{filedir}'"
		else
			"No snips found in the specified files or directories."
		end
	end

  def status_line(line, type, file)
  	if type == "js"
   	  "// Snipped from #{file}#{line_check(line)} on #{Time.now.strftime("%m-%d-%Y")}"
   	elsif type == "erb"
   	  "<!-- Snipped from #{file}#{line_check(line)} on #{Time.now.strftime("%m-%d-%Y")}-->"
   	else
   		"# Snipped from #{file}#{line_check(line)} on #{Time.now.strftime("%m-%d-%Y")}"
   	end
  end

  def line_check(line)
  	line ? ':' + line.to_s : nil
  end

  def snip_terminal_status(filename, line)
  	if line
  		"#{filename}:#{line} snipped"
  	else
  		nil
  	end
  end

  def specify_path
  	"Please specify where you would like to save your snippets by running 'snip -f <filepath>'"
  end

  def output_file_not_found(file)
  	"Output file '#{file}' not found, please specify existing file location or desired location for new file by running 'snip -f <filepath>'"
  end

  def new_file(filename)
  	"New snippet file created at #{File.absolute_path(filename)}"
  end

  def terminal_help_message
  	"

*** First time setup: ***

  snip -f <directory>

This specifies the directory where you would like to save your snippets. 'my_snips.txt' will be automatically created if it doesn't already exist. If you move your my_snips.txt file, you will need to run 'snip -f' again.

Ruby and JavaScript snippet files will be automatically created in the same directory as the .txt file.


*** To add snip tags into your code: ***

Ruby:

  # <snip> Title goes here
  5.times do {|x| puts x}
  # </snip>

JS:

  // <snip> Title goes here
  var test = 1234;
  // </snip>

You can alternatively use <$> and </$>. Your tags will be replaced with <*snip*> and/or <*$*> after running 'snip'.


*** Ongoing usage: ***

  snip <filename> - process a single file
  snip <directory> - process a directory recursively
  snip -l - view log history if you need to debug previous snips
  snip -d - display your snips in terminal
  snip -i - reindexes your snippet files (after deleting old snips, etc)

Visit https://github.com/jgerminario/snip for more information or to submit bug reports/feature requests.

"
	end

	def new_file_path
		"Snippet file location saved as '#{File.absolute_path(ARGV[1])}/my_snips.txt'"
	end

	def no_args_message
		"Welcome to snip. Type 'snip --help' for help"
	end

	def specify_filename(filename)
		if filename
			"Your file is located at #{filename}"
		else
			"No output file found, please specify a filename after '-f'"
		end
	end

	def need_to_specify_directory
		"Please specify an existing directory to save your snippets to"
	end

	def show_log(log_file)
		if File.readlines(log_file)[0]
			File.readlines(log_file)
		else
			"Log file is empty"
		end
	end

	def show_snips(file)
		if file
			if File.readlines(file)[0]
				File.readlines(file)
			else
				"Snippet file is empty"
			end
		else
			"Snippet file doesn't exist. Specify where you would like to save your snippets by running 'snip -f <filepath>"	
		end
	end

	def reindexed
		"Your snippet files have been reindexed"
	end

	def clipboard_command
		"Run 'snip -c' or specify code type (js, rb, erb, misc) and a title string with: 
 'snip -c rb \"Using string interpolation\"' "
	end

	def display_error
		"Specify code type (js, rb, erb) and/or a search string, e.g. 'snip -d js \"event delegation\"', or snip -d .' for all snips"
	end
	def no_results
		"No matching snippet files found"
	end
end
