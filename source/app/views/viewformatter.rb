# View component for file writing operations and possibly terminal output
require 'date'

module ViewFormatter

	extend self

	def snippet_indexer(index, title)
		"# **** Snippet " + (index).to_s + ": #{title} **** \n"
	end

	def success_message(filedir)
		"Your snippet file has been successfully updated with #{Snippet.snippet_counter} new snips at: '#{filedir}'"#.blue
	end

  def status_line(line)
    "# Snipped from #{SourceFileReaderWriter.file_to_open}:#{line} on #{Time.now.strftime("%m-%d-%Y")}"
  end

  def snip_terminal_status(filename, line)
  	"#{File.absolute_path(filename)}:#{line} snipped"
  end

  def specify_path
  	"Please specify where you would like to save your snippet file by running 'snip -f <filepath>'"
  end

  def output_file_not_found
  	"Output file not found, please specify existing file location/name or desired location/name for new file by running 'snip -f <filepath>'"
  end

  def new_file(filename)
  	"New snippet file created at #{File.absolute_path(filename)}"
  end

  def terminal_help_message
  	"
Usage:

snip <filename.rb> - process a single file
snip <directory> - process a directory recursively
snip -f <filename> - set your saved-snippets filename and directory. 
(If you move your saved-snippets file, you will need to run this command again. Your existing snippets will not be overriden)

To add snip tags into your code, example:
	# <snip> Title goes here
	5.times do {|x| puts x}
	# </snip>

Alternately, you can use <$> and </$>. When you run snip on your files, your tags will be replaced as follows: <snip> and <$>

"
	end

	def new_file_path
		"Snippet file location saved as #{File.absolute_path(ARGV[1])}"
	end

	def no_args_message
		"Please specify a file or a path to process or type 'snip --help' for help"
	end

	def specify_filename
		"Please specify a filename after '-f'"
	end

end
