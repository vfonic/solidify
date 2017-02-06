require 'rails/engine'

module SolidusLiquid
  class Engine < ::Rails::Engine
    config.autoload_paths << SolidusLiquid::Engine.root.join('app', 'controllers', 'solidus_liquid', 'responders')
    isolate_namespace SolidusLiquid
    engine_name 'solidus_liquid'

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
