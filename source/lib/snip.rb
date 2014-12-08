require "snip/version"
# require_relative '../config/environment'
require_relative '../app/controllers/controller'
require_relative '../app/models/utils/batchprocessing'

module Snip
	class Run
		def execute
			unless ARGV[0]
				abort("Please specify a file or a path to process or type 'snip --help' for help")
			end

			if ARGV[0] == "--help"
				abort("
Usage:

snip <filename.rb> - process a single file
snip <directory> - process a directory recursively
snip -f <filename> - set your saved-snippets filename and directory. 
(If you move your saved-snippets file, you will need to run this command again. Your existing snippets will not be overriden)

To add snip tags into your code, example:
	# <snip> Title goes here
	5.times do {|x| puts x}
	# </snip>

Alternately, you can use <$> and </$>. When you run snip on your files, your tags will be replaced as follows: <*snip*> and <*$*>

")
			end

			if ARGV[0] == "-f"
				DestinationFileWriter.save_file_path_to_config_file(ARGV[1])
				abort("Snippet file location saved as #{File.absolute_path(ARGV[1])}")
			end

			DestinationFileWriter.check_config_file_for_snip_file

			if ARGV[0].include?(".rb")
			  CommandLineController.run(ARGV[0])
			else
			  BatchProcessing.process(ARGV[0])
			end

			puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
		end
	end
  # Your code goes here...
end
