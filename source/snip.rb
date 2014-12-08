## Stypi session: https://code.stypi.com/jgerminario/snip
## debugger: gem install debugger from command line

# require 'debugger'
# require 'pry'
# require 'pry-nav'
# require 'colorize'
require_relative 'config/environment'
require_relative 'app/controllers/controller'

CommandLineController.run



puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)


#Tests:
# p file_write.file_exists?
# p file_write.create_new_file
# p file_write.write_file
# p Snippet.snippet_array
