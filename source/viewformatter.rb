# View component for file writing operations and possibly terminal output
require 'date'

module ViewFormatter

	extend self

	def snippet_indexer(index, title)
		"# **** Snippet " + (index+1).to_s + ": #{title} **** \n"
	end

	def success_message(filedir)
		"Your snippet file has been successfully created at: '#{filedir}'"#.blue
	end

  def status_line(line)
    "# **** #{SourceFileReaderWriter.file_to_open}; #{line}; #{Date.today}"
  end
end
