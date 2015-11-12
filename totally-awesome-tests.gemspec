# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'totes/version'

Gem::Specification.new do |spec|
  spec.name          = "totally-awesome-tests"
  spec.version       = Totes::VERSION
  spec.authors       = ["Nikolay Nemshilov"]
  spec.email         = ["nemshilov@gmail.com"]

  spec.summary       = %q{Like totally awesome testing framework}
  spec.description   = %q{Like totally awesome testing framework. Did I mention "totally" already?}
  spec.homepage      = "https://github.com/MadRabbit/totally-awesome-tests"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
end
