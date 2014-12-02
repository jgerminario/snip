require_relative 'sourcefilereader'
require_relative 'codescanner'
require_relative 'destinationfilewriter'

module CommandLineController

  extend self

  def run
    file_read = SourceFileReaderWriter.new(ARGV.first)
    to_run = file_read.convert_to_array_of_lines
    CodeScanner.run(to_run)
    DestinationFileWriter.run(Snippet.snippet_array)
    puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
    file_read.overwrite_existing_snips
  end
end