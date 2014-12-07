class Snippet < ActiveRecord::Base
  @@snippet_array = []
  # attr_reader :code, :title, :line, :filename

  def self.snippet_array
    @@snippet_array
  end

  # def initialize(args = {})
  #   @code = args[:code_array]
  #   @title = args[:title]
  #   @@snippet_array << self
  #   @line = args[:line]
  #   @filename = args[:filename]
  #   # self.create(args)
  # end

  def self.parse(args = {})
  	snip = self.create(args)
    @@snippet_array << snip
  end

end