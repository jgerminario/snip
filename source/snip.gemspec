# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snip/version'

Gem::Specification.new do |spec|
  spec.name          = "snip"
  spec.version       = Snip::VERSION
  spec.authors       = ["jgerminario", "philril", "cmliotta"]
  spec.email         = ["jgerminario@gmail.com"]
  spec.summary       = %q{Snip is a code snippet tool to save your most interesting code for later review}
  spec.description   = %q{Using a <snip> tag, you can mark snippets in code commands without interrupting your workflow. At the end of the day, run Snip to automatically gather your snippets from your file for easy review. Compatible with Ruby and JavaScript, with more to come.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  # spec.executables = ["snip"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "db", "config", "app"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "activerecord", "~>4.1"

end
