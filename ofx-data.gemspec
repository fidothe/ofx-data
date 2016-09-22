# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ofx/data/version'

Gem::Specification.new do |spec|
  spec.name          = "ofx-data"
  spec.version       = OFX::Data::VERSION
  spec.authors       = ["Matt Patterson"]
  spec.email         = ["matt@reprocessed.org"]

  spec.summary       = %q{Generate OFX XML documents}
  spec.description   = <<EOS
The Open Financial eXchange standard uses XML-based documents to transfer data
around. This gem implements an object model and serializer for those documents,
leaving the Request / Response HTTP-based parts of the specification well alone
EOS
  spec.homepage      = "https://github.com/fidothe/ofx-data"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "builder", "~> 3.2"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
