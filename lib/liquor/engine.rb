require 'rails/engine'

module Liquor
  class Engine < ::Rails::Engine
    config.autoload_paths << Liquor::Engine.root.join('app', 'controllers', 'liquor', 'responders')
    isolate_namespace Liquor
    engine_name 'liquor'

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
