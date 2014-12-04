# View component for file writing operations and possibly terminal output

module ViewFormatter

	extend self

	def snippet_indexer(index)
		"# **** Snippet " + (index+1).to_s + " **** \n"
	end

	def success_message(filedir)
		"Your snippet file has been successfully created at: '#{filedir}'"#.blue
	end
end
