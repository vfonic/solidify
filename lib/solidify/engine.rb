require 'rails/engine'

module Solidify
  class Engine < ::Rails::Engine
    config.autoload_paths << Engine.root.join(
      'app', 'controllers', 'solidify', 'responders'
    )
    isolate_namespace Solidify
    engine_name 'solidify'

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    def self.activate
      Dir.glob(File.join(__dir__, '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
