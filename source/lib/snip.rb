require "snip/version"
require "clipboard"
require_relative 'controllers/controller'
require_relative 'models/utils/batchprocessing'
require_relative 'languages/languages'

  
module Snip
  class Run

### utility
    def argv_ext_check(pos)
      if ARGV[pos]
        Language.supports?(ARGV[pos])
      else
        false
      end
    end

### execute flow for ARGV - refactor into separate methods

    def execute
      unless ARGV[0]
        abort(ViewFormatter.no_args_message)
      end

      if ARGV[0] == "--help" || ARGV[0] == "-h"
        abort(ViewFormatter.terminal_help_message)
      end

      # set file location
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


      # show log
      if ARGV[0] == "-l" 
        puts ViewFormatter.show_log(DestinationFileWriter.log_filepath)
        abort
      end

      # reindex
      if ARGV[0] == "-i"
        DestinationFileWriter.reindex_all
        abort(ViewFormatter.reindexed)
      end

      # restore whitespace
      if ARGV[0] == "-w"
        display_file = DestinationFileWriter.return_display_file
        DestinationFileWriter.restore_whitespace(display_file, SearchDisplay.run(display_file))
        abort(ViewFormatter.whitespace_success)
      end

      # delete
      if ARGV[0] == "--delete"
        unless ARGV[1]
          abort(ViewFormatter.delete_error)
        end
        if ARGV[1].include?(",")
          ids = ARGV[1].split(",")
        else
          ids = [ARGV[1]]
        end
        display_file = DestinationFileWriter.return_display_file
        DestinationFileWriter.rewrite_file(display_file, SearchDisplay.delete(display_file, ids))
        DestinationFileWriter.reindex_all
        abort(ViewFormatter.delete_success)
      end

      # display snips function
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

      # at this point we need to male sure config file exists - may want to refactor this check to occur before -d (handled in show_snips currently)
      DestinationFileWriter.check_config_file_for_snip_file

      # clipboard function
      if ARGV[0] == "-c"
        code = Clipboard.paste + "\n"
        
        if ARGV[2] && (Language.supports?(ARGV[1]) || ARGV[1] == "misc")
          type = ARGV[1]
          title = ARGV[2]
          origin = ViewFormatter.clipboard_origin(type)
        elsif ARGV[1].nil?
          puts ViewFormatter.clipboard_prompts[0]
          type = $stdin.gets.chomp
          puts ViewFormatter.clipboard_prompts[1]
          title = $stdin.gets.chomp
        else
          abort(ViewFormatter.clipboard_instructions)
        end

        Snippet.new(code: code, title: title, line: nil, filename: origin)
        CommandLineController.file_writing
        abort(ViewFormatter.clipboard_success(code))
      end


      # no CL arguments (e.g. '-c') - straight snip
      if File.directory?(ARGV[0])
        BatchProcessing.process(ARGV[0])
      elsif File.file?(ARGV[0])
        file_arr = ARGV[0].split('.')
        if file_arr.length > 1 && Language.supports?(file_arr[-1])
          CommandLineController.run(ARGV[0])
        else
          abort(ViewFormatter.invalid_input_file)
        end
      else
        abort(ViewFormatter.input_file_not_found)
      end

      puts ViewFormatter.success_message(DestinationFileWriter.full_file_directory)
    end
  end
end
