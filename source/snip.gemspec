# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snip/version'

Gem::Specification.new do |spec|
  spec.name          = "snipgem"
  spec.version       = Snip::VERSION
  spec.authors       = ["jgerminario", "philril", "cmliotta"]
  spec.email         = ["jgerminario@gmail.com"]
  spec.summary       = %q{Snip is a code snipping tool to save your most interesting code for later review.}
  spec.description   = %q{Using simple tags, you can mark snips in your code without interrupting your workflow. At the end of the day, run 'snip' to gather your snips from all your code for easy review. Compatible with Ruby and JavaScript. Visit the GitHub homepage for further instructions and developer contact details.}
  spec.homepage      = "https://github.com/jgerminario/snip"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  # spec.executables = ["snip"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "db", "config", "app", "log"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "clipboard", "~> 1.0"
  # spec.add_development_dependency "sqlite3", "~> 1.3"
  # spec.add_development_dependency "activerecord", "~>4.1"

end
