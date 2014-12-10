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
					DestinationFileWriter.save_file_path_to_config_file(ARGV[1])
					abort(ViewFormatter.new_file_path)
				else
					abort(ViewFormatter.specify_filename)
				end
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
end
