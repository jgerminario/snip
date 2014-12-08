require "snip/version"
require_relative '../config/environment'
require_relative '../app/controllers/controller'
require_relative '../app/models/utils/batchprocessing'

module Snip
	class Run
		def execute
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
