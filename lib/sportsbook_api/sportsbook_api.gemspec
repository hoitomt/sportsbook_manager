# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sportsbook_api/version'

Gem::Specification.new do |spec|
  spec.name          = "sportsbook_api"
  spec.version       = SportsbookApi::VERSION
  spec.authors       = ["Michael Hoitomt"]
  spec.email         = ["mhoitomt@primedia.com"]
  spec.description   = %q{Retrieves data from Sportsbook.ag using credentials}
  spec.summary       = %q{Retrieves data from Sportsbook.ag using credentials}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_dependency "mechanize", "~> 2.7.2"
  spec.add_dependency "virtus", "~> 0.5.5"
end
