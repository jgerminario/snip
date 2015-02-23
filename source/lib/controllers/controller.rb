require_relative '../models/utils/sourcefilereader'
require_relative '../models/utils/codescanner'
require_relative '../models/utils/destinationfilewriter'
require_relative '../models/utils/searchfile'
require_relative '../languages/languages'

module CommandLineController

  extend self

  def run(file)
    file_read = SourceFileReaderWriter.new(file)
    to_run = file_read.convert_to_array_of_lines
    mismatch_status = CodeScanner.run(to_run, SourceFileReaderWriter.file_to_open)
    abort(ViewFormatter.mismatched_tags(mismatch_status)) if mismatch_status
    file_writing
    file_read.overwrite_existing_snips
  end

  def file_writing
    DestinationFileWriter.run(Snippet.snippet_array)
    Language.languages.keys.each do |lang|
      DestinationFileWriter.run(Snippet.select_lang_snippets(lang), lang) if Snippet.select_lang_snippets(lang).any?
    end
    Snippet.snippet_array = []
  end

end
