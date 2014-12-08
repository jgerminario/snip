require "snip/version"
require_relative '../config/environment'
require_relative '../app/controllers/controller'

module Snip
	class Test
		def say_hello
			CommandLineController.run
			puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
		end
	end
  # Your code goes here...
end
