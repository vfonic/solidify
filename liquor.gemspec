# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liquor/version'

Gem::Specification.new do |spec|
  spec.name          = "liquor"
  spec.version       = Liquor::VERSION
  spec.authors       = ["Viktor Fonic"]
  spec.email         = ["viktor.fonic@gmail.com"]

  spec.summary       = 'Contains theme and asset models for liquid files'
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/vfonic/liquor'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2.7.1"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
