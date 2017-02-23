# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'solidus_liquid/version'

Gem::Specification.new do |spec|
  spec.name          = "solidus_liquid"
  spec.version       = SolidusLiquid::VERSION
  spec.authors       = ["Viktor Fonic"]
  spec.email         = ["viktor.fonic@gmail.com"]

  spec.summary       = 'Solidus meets Shopify liquid theme files'
  spec.description   = 'Solidus extension for using Shopify liquid theme files'
  spec.homepage      = 'https://github.com/vfonic/solidus_liquid'
  spec.license       = 'MIT'
  spec.email         = 'viktor.fonic+solidus_liquid@gmail.com'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'carrierwave'
  spec.add_dependency 'devise', '~> 4.1'
  spec.add_dependency 'fog-aws'
  spec.add_dependency 'rails', '~> 5.0.1'
  spec.add_dependency 'rails-settings-cached'
  spec.add_dependency 'redis'
  spec.add_dependency 'sass'
  spec.add_dependency 'liquid-rails'
  spec.add_dependency 'responders'
  spec.add_dependency 'solidus_core', '~> 2.1'
  spec.add_dependency 'solidus_auth_devise', '~> 1.6.2'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'liquid4-rails5'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec', '1.4.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
  # solidus_auth_devise dependencies
  spec.add_development_dependency 'sass-rails'
  spec.add_development_dependency 'coffee-rails'
end
