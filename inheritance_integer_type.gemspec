# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inheritance_integer_type/version'

Gem::Specification.new do |spec|
  spec.name          = "inheritance_integer_type"
  spec.version       = InheritanceIntegerType::VERSION
  spec.authors       = ["Kyle d'Oliveira"]
  spec.email         = ["kyle@goclio.com"]
  spec.summary       = %q{Allow the type field in teh DB to be an integer rather than a string}
  spec.description   = %q{Use integers rather than strings for the type fields for single table inheritance}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activerecord", "3.2.11"
  spec.add_development_dependency "mysql", "2.8.1"
  spec.add_development_dependency "debugger" 
end
