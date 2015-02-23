require "snip/version"
require "clipboard"
require_relative 'controllers/controller'
require_relative 'models/utils/batchprocessing'
require_relative 'languages/languages'

  
module Snip
  class Run

### execution flow for ARGV
    def execute
      unless ARGV[0]
        abort(ViewFormatter.no_args_message)
      end

      if ARGV[0] == "--help" || ARGV[0] == "-h"
        abort(ViewFormatter.terminal_help_message)
      end

      # set file location
      if ARGV[0] == "-f"
        set_output_file_location
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
        DestinationFileWriter.restore_whitespace(display_file, SearchDisplay.return_search_results(display_file))
        abort(ViewFormatter.whitespace_success)
      end

      # delete
      if ARGV[0] == "--delete"
        unless ARGV[1]
          abort(ViewFormatter.delete_error)
        end
        delete_specified(ARGV[1])
        abort(ViewFormatter.delete_success)
      end

      # display snips function
      if ARGV[0] == "-a"
        puts ViewFormatter.show_snips(DestinationFileWriter.snip_filepath)
        abort
      end

      if ARGV[0] == "-s" || ARGV[0] == "-d"
        search_snips
        abort
      end

      # at this point we need to make sure config file exists - may want to refactor this check to occur before -d (handled in show_snips currently)
      DestinationFileWriter.check_config_file_for_snip_file

      # clipboard function
      if ARGV[0] == "-c"
        code = Clipboard.paste + "\n"
        snip_from_clipboard(code)
        abort(ViewFormatter.clipboard_success(code))
      end

      # no CL arguments (e.g. '-c') - straight snip
      perform_file_or_batch_processing
    end

    # -f
    def set_output_file_location
      if ARGV[1]
        check_if_valid_directory(ARGV[1])
      else
        abort(ViewFormatter.check_for_file((DestinationFileWriter.snip_filepath)))
      end
    end

    def check_if_valid_directory(directory)
      if File.directory?(directory)
        DestinationFileWriter.save_file_path_to_config_file(directory)
        abort(ViewFormatter.new_file_path)
      else
        abort(ViewFormatter.need_to_specify_a_directory)
      end
    end

    # --delete
    def delete_specified(items)
      if items.include?(",")
        items = items.split(",")
      else
        items = [items]
      end
      display_file = DestinationFileWriter.return_display_file
      DestinationFileWriter.rewrite_file(display_file, SearchDisplay.delete(display_file, items))
      DestinationFileWriter.reindex_all
    end

    # -d
    def search_snips
      if incorrect_num_of_args?(:d)
        abort(ViewFormatter.display_error) 
      end

      if Language.supports?(ARGV[1]) # ext search
        ext_to_search = ARGV[1]
        string_to_search = ARGV[2]
      else # string search only
        string_to_search = ARGV[1]
      end

      puts SearchDisplay.return_search_results(DestinationFileWriter.return_display_file, string_to_search, ext_to_search)
    end

    def incorrect_num_of_args?(method)
      !ARGV[1] || ARGV[3] || (!Language.supports?(ARGV[1]) && ARGV[2]) if method == :d
    end

    # -c
    def snip_from_clipboard(code)
      if ARGV[2] && (Language.supports?(ARGV[1]) || ARGV[1] == "misc") #ARGV[2] is title, ARGV[1] is ext
        type = ARGV[1]
        title = ARGV[2]
      elsif ARGV[1].nil?
        puts ViewFormatter.clipboard_prompts[0]
        type = $stdin.gets.chomp
        puts ViewFormatter.clipboard_prompts[1]
        title = $stdin.gets.chomp
      else
        abort(ViewFormatter.clipboard_instructions)
      end

      origin = ViewFormatter.clipboard_origin(type)
      Snippet.new(code: code, title: title, line: nil, filename: origin)
      CommandLineController.file_writing
    end

    # no flags
    def perform_file_or_batch_processing
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
