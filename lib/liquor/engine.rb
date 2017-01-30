module Liquor
  class Engine < Rails::Engine
    isolate_namespace Liquor
    engine_name 'liquor'
  end
end
