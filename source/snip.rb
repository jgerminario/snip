## Stypi session: https://code.stypi.com/jgerminario/snip
## debugger: gem install debugger from command line

# require 'debugger'
# require 'pry'
# require 'pry-nav'
# require 'colorize'
require_relative 'config/environment'
require_relative 'app/controllers/controller'
require_relative 'app/models/utils/batchprocessing'



if ARGV[0]#.include?("*.rb")
  CommandLineController.run(ARGV[0])
else
  BatchProcessing.process
end


#Tests:
# p file_write.file_exists?
# p file_write.create_new_file
# p file_write.write_file
# p Snippet.snippet_array
