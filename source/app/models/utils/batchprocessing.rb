class BatchProcessing

  def self.process(directory)
  	directory = directory.chomp('/')
    Dir.glob(directory + "/**/*.{rb}") do |file|
      next if file == '.' or file == '..'
      CommandLineController.run(file)
    end
  end

end
