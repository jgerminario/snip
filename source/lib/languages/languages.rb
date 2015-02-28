class Language

  def self.languages
    {
      "js" => ["//"],
      "erb" => ["<!--", "-->"],
      "rb" => ["#"],
      "html" => ["<!--", "-->"],
      "py" => ["#"],
      "php" => ["<?php /*", "*/ ?>"],
      "css" => ["/*", "*/"]
    }
  end

  def self.supports?(lang)
    self.languages.key?(lang)
  end

end
