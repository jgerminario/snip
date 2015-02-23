class BatchProcessing

  require_relative '../../languages/languages'

  def self.process(directory)
  	directory = directory.chomp('/')
    Dir.glob(directory + "/**/*.{#{Language.languages.keys.join(',')}}") do |file|
      next if file == '.' or file == '..'
      CommandLineController.run(file)
    end
  end

end
