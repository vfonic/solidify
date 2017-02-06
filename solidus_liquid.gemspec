# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'solidus_liquid/version'

Gem::Specification.new do |spec|
  spec.name          = "solidus_liquid"
  spec.version       = SolidusLiquid::VERSION
  spec.authors       = ["Viktor Fonic"]
  spec.email         = ["viktor.fonic@gmail.com"]

  spec.summary       = 'Contains theme and asset models for liquid files'
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/vfonic/solidus_liquid'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'carrierwave'
  spec.add_dependency 'fog-aws'
  spec.add_dependency 'rails', '~> 5.0.1'
  spec.add_dependency 'rails-settings-cached'
  spec.add_dependency 'redis'
  spec.add_dependency 'sass'
  spec.add_dependency 'liquid-rails'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
end
