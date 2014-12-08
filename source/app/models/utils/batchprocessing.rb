class BatchProcessing

  def self.process
    Dir.foreach("lib/snips_to_process") do |file|
      next if file == '.' or file == '..'
      CommandLineController.run("lib/snips_to_process/#{file}")
    end
  end

end
