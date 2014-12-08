require_relative '../models/utils/sourcefilereader'
require_relative '../models/utils/codescanner'
require_relative '../models/utils/destinationfilewriter'
require 'active_record'

module CommandLineController

  extend self

  def run(file)
    file_read = SourceFileReaderWriter.new(file)
    to_run = file_read.convert_to_array_of_lines
    CodeScanner.run(to_run, ARGV.first)
    DestinationFileWriter.run(Snippet.snippet_array)
    puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
    file_read.overwrite_existing_snips

    Snippet.snippet_array = []
  end
end
