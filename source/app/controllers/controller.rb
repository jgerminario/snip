require_relative '../models/utils/sourcefilereader'
require_relative '../models/utils/codescanner'
require_relative '../models/utils/destinationfilewriter'

module CommandLineController

  extend self

  def run(file)
    file_read = SourceFileReaderWriter.new(file)
    to_run = file_read.convert_to_array_of_lines
    CodeScanner.run(to_run, SourceFileReaderWriter.file_to_open)
    DestinationFileWriter.run(Snippet.snippet_array)
    DestinationFileWriter.run(Snippet.rb_snippets, "rb") if Snippet.rb_snippets.any?
    DestinationFileWriter.run(Snippet.js_snippets, "js") if Snippet.js_snippets.any?
    file_read.overwrite_existing_snips

    Snippet.snippet_array = []
  end
end
