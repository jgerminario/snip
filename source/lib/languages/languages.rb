class Language

  def self.languages
    {
      "js" => ["//"],
      "erb" => ["<--", "-->"],
      "rb" => ["#"],
      "html" => ["<!--", "-->"]
    }
  end

  def self.supports?(lang)
    self.languages.key?(lang)
  end

end
