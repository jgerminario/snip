require 'rspec'
# require 'active_record'
require_relative '../lib/controllers/controller'
# require_relative '../config/environment'

describe "This program" do

	# Setting up a test file and test code to work off of
	before :all do

		@rspec_test_file = "rspec_test.rb"
		@num_of_snips = rand(1..10)
		@test_file_code =
				[
				 "#<snip>\n",
				 "5.times {|x| p x}\n",
				 "5.times {|x| p x}\n",
				 "#</snip>\n",
				 "\n"
				 ]*@num_of_snips

		File.open(@rspec_test_file, 'w+') do |f|
			@test_file_code.each do |code|
				f << code
			end
		end

		ARGV[0] = @rspec_test_file

	end

	# Deleting test file after completion of tests
	after :all do
		File.delete(@rspec_test_file)
	end

	describe SourceFileReaderWriter do
		let(:open_file) {SourceFileReaderWriter.new(ARGV.first)}

		describe "::new" do

			it "should read command line for filename" do
		 	  command_line = ARGV[0]
		 	  open_file
		 	  expect(SourceFileReaderWriter.file_to_open).to eq(command_line)
		 	end
		 end

	 	describe ".convert_to_array_of_lines"	do

	 		it "converts file input to an array" do
	 			code_array = open_file.convert_to_array_of_lines
	 			expect(code_array).to be_a Array
	 		end

	 	end

	end


	describe CodeScanner do

		let(:empty_array) {[]}
		let(:test_array) {SourceFileReaderWriter.new(@rspec_test_file).convert_to_array_of_lines}

		before :all do

		end

		after :each do
			Snippet.class_variable_set(:@@snippet_array, [])
		end

	 	describe "::run" do

	 		it "creates an empty array for an empty input" do
	 			CodeScanner.run(empty_array, @rspec_test_file)
	 			expect(CodeScanner.scan_array).to be_a Array
	 			expect(CodeScanner.scan_array.length).to eq(0)
	 		end

	 		it "creates snippets for each snip tag in the code array" do
	 			CodeScanner.run(test_array, @rspec_test_file)
	 			expect(Snippet.snippet_array.length).to eq(@num_of_snips)
	 			expect(Snippet.snippet_array.first).to be_a Snippet
		 	end


		 	it "removes opening and closing tags from the local scan array" do
		 		CodeScanner.run(test_array, @rspec_test_file)
		 		expect(CodeScanner.scan_array.join.include?('snip>')).to eq(false)
		 	end

		end

  end

end


describe "::run special cases" do

	before :all do

		@rspec_test_file = "rspec_test.rb"
		@num_of_snips = rand(1..10)
		@test_file_code =
			  ["#    erwer <snip>Title\n",
 				 "5.times {|x| pppppp x}\n",
 				 "# rwerewr </snip>  rewre \n",
 				 "\n"
 				]*@num_of_snips

		File.open(@rspec_test_file, 'w+') do |f|
			@test_file_code.each do |code|
				f << code

			end
		end

		ARGV[0] = @rspec_test_file

	end

	# Deleting test file after completion of tests
	after :all do
		File.delete(@rspec_test_file)
	end

	let(:empty_array) {[]}
	let(:test_array) {SourceFileReaderWriter.new(@rspec_test_file).convert_to_array_of_lines}

 	it "finds tags anywhere in the line, not just adjacent to the # comment symbol" do
 		p Snippet.snippet_array
 		CodeScanner.run(test_array, @rspec_test_file)
	 	expect(Snippet.snippet_array.length).to eq(@num_of_snips)
 	end

 	it "contains the expected title" do
 		expect(Snippet.snippet_array[0].title).to eq("Title")
 	end

 	it "contains the expected filename" do
	 	expect(Snippet.snippet_array[0].filename).to eq(@rspec_test_file)
	end

  it "contains the expected line number" do
    expect(Snippet.snippet_array[0].line).to eq(1)
  end

end







