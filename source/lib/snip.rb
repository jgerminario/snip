require "snip/version"
require_relative '../app/controllers/controller'
require_relative '../app/models/utils/batchprocessing'

module Snip
	class Run
		def execute
			unless ARGV[0]
				abort(ViewFormatter.no_args_message)
			end

			if ARGV[0] == "--help"
				abort(ViewFormatter.terminal_help_message)
			end

			if ARGV[0] == "-f"
				if !ARGV[1].nil?
					if File.directory?(ARGV[1])
						DestinationFileWriter.save_file_path_to_config_file(ARGV[1])
						abort(ViewFormatter.new_file_path)
					else
						abort(ViewFormatter.need_to_specify_directory)
					end
				else
					abort(ViewFormatter.specify_filename)
				end
			end

			if ARGV[0] == "-l"
				puts ViewFormatter.show_log(DestinationFileWriter.log_filepath)
				abort
			end

			if ARGV[0] == "-d"
				puts ViewFormatter.show_snips(DestinationFileWriter.snip_filepath)
				abort
			end

			DestinationFileWriter.check_config_file_for_snip_file

			if File.directory?(ARGV[0])
				BatchProcessing.process(ARGV[0])
			elsif File.file?(ARGV[0])
				if ARGV[0].end_with?(".rb") || ARGV[0].end_with?(".js")
				  CommandLineController.run(ARGV[0])
				else
					abort(ViewFormatter.invalid_file)
				end
			else
				abort(ViewFormatter.file_not_found)
			end

			puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
		end
	end
end
