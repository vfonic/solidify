module Liquor
  class Engine < Rails::Engine
    isolate_namespace Liquor
    engine_name 'liquor'

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
