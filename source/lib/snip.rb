require "snip/version"
require "clipboard"
require_relative 'controllers/controller'
require_relative 'models/utils/batchprocessing'

module Snip
	class Run
		def argv_ext_check(pos)
			if ARGV[pos]
				(ARGV[pos] == "rb" || ARGV[pos] == "js" || ARGV[pos] == "erb")
			else
				false
			end
		end

		def display_file
			DestinationFileWriter.return_display_file
		end

		def execute
			unless ARGV[0]
				abort(ViewFormatter.no_args_message)
			end

			if ARGV[0] == "--help"
				abort(ViewFormatter.terminal_help_message)
			end

			if ARGV[0] == "-f"
				if !ARGV[1].nil?
					if File.directory?(ARGV[1])
						DestinationFileWriter.save_file_path_to_config_file(ARGV[1])
						abort(ViewFormatter.new_file_path)
					else
						abort(ViewFormatter.need_to_specify_directory)
					end
				else
					abort(ViewFormatter.specify_filename((DestinationFileWriter.snip_filepath)))
				end
			end

			if ARGV[0] == "-l" 
				puts ViewFormatter.show_log(DestinationFileWriter.log_filepath)
				abort
			end

			if ARGV[0] == "-i"
				DestinationFileWriter.reindex_all
				abort(ViewFormatter.reindexed)
			end

			if ARGV[0] == "-w"
				DestinationFileWriter.restore_whitespace(DestinationFileWriter.return_display_file, SearchDisplay.run(DestinationFileWriter.return_display_file))
				abort("Whitespace restored")
			end

			if ARGV[0] == "--delete"
				unless ARGV[1]
					abort("Please specify which snippets you wish to delete")
				end
				if ARGV[1].include?(",")
					ids = ARGV[1].split(",")
				else
					ids = [ARGV[1]]
				end
				DestinationFileWriter.rewrite_file(display_file, SearchDisplay.delete(display_file, ids))
				DestinationFileWriter.reindex_all
				abort("Snips #{ARGV[1]} deleted from my_snips.txt (other files must be modified manually)")
			end

			if ARGV[0] == "-d"
				if argv_ext_check(1)
					if ARGV[2]
						if !ARGV[3].nil?
							abort(ViewFormatter.display_error)
						else
							puts CommandLineController.display_search(ARGV[2], "." + ARGV[1])
						end
					else
						puts CommandLineController.display_search("", "." + ARGV[1])
					end
				elsif ARGV[1] == "."
					puts ViewFormatter.show_snips(DestinationFileWriter.snip_filepath)
				elsif !ARGV[1].nil?
					if !ARGV[2].nil?
						abort(ViewFormatter.display_error)
					else
						puts CommandLineController.display_search(ARGV[1], "")
				  end	
				else
					abort(ViewFormatter.display_error)
				end
				abort
			end

			DestinationFileWriter.check_config_file_for_snip_file

			if ARGV[0] == "-c"
				code = Clipboard.paste + "\n"
				
				if !ARGV[2].nil? && (ARGV[1] == "rb" || ARGV[1] == "js" || ARGV[1] == "erb" || ARGV[1] == "misc")
					type = ARGV[1]
					title = ARGV[2]
				elsif ARGV[1].nil?
					puts "Type of code (e.g. rb, js, erb) or press enter for misc:"
					type = $stdin.gets.chomp
					puts "Title:"
				  title = $stdin.gets.chomp
				else
					abort(ViewFormatter.clipboard_command)
				end

				if type == "rb" || type == "js" || type == "erb"
					origin = "clipboard (.#{type})"
				else
					origin = "clipboard"
				end

				Snippet.new(code: code, title: title, line: nil, filename: origin)
				CommandLineController.file_writing
				abort("Your code has been snipped:\n\n#{code}")
			end

			if File.directory?(ARGV[0])
				BatchProcessing.process(ARGV[0])
			elsif File.file?(ARGV[0])
				if ARGV[0].end_with?(".rb") || ARGV[0].end_with?(".js") ||ARGV[0].end_with?(".erb") 
				  CommandLineController.run(ARGV[0])
				else
					abort(ViewFormatter.invalid_file)
				end
			else
				abort(ViewFormatter.file_not_found)
			end

			puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
		end
	end
end
