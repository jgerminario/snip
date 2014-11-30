## Stypi session: https://code.stypi.com/jgerminario/snip
## debugger: gem install debugger from command line

require 'debugger'

require_relative 'filereader'
require_relative 'codescanner'
require_relative 'filewriter'

module CommandLineController

  extend self

  def run
    file_read = FileReader.new(ARGV.first)
    to_run = file_read.convert_to_array_of_lines
    CodeScanner.run(to_run)
    FileWriter.run(Snippet.snippet_array)
    puts ViewFormatter.success_message(FileWriter.full_file_directory)
  end
end

CommandLineController.run

#Tests:
# p file_write.file_exists?
# p file_write.create_new_file
# p file_write.write_file
# p Snippet.snippet_array
