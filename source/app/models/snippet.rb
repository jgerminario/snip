class Snippet
attr_accessor :snippet_array

  @@snippet_array = []
  @@snippet_counter = 0
  attr_reader :code, :title, :line, :filename

  def self.snippet_array
    @@snippet_array
  end

  def self.snippet_counter
    @@snippet_counter
  end

  def self.snippet_array=(arg)
    @@snippet_array = arg
  end

  def self.rb_snippets
    @@snippet_array.select {|snippet| snippet.filename.end_with?(".rb") || snippet.filename.end_with?("(.rb)")}
  end

  def self.erb_snippets
    @@snippet_array.select {|snippet| snippet.filename.end_with?(".erb") || snippet.filename.end_with?("(.erb)") }
  end

  def self.js_snippets
    @@snippet_array.select {|snippet| snippet.filename.end_with?(".js") || snippet.filename.end_with?("(.js)") }
  end

  def initialize(args = {})
    @code = args[:code]
    @title = args[:title]
    @@snippet_array << self
    @@snippet_counter += 1
    @line = args[:line]
    @filename = args[:filename]
  end

end