class BatchProcessing

  def self.process(directory)
    Dir.foreach(directory) do |file|
      next if file == '.' or file == '..'
      CommandLineController.run("#{directory}/#{file}")
    end
  end

end
