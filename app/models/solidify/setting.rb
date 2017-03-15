module Solidify
  # RailsSettings Model
  class Setting < ::RailsSettings::Base
    # self.table_name = "#{Solidify::Engine.engine_name}_settings"
    source Rails.root.join('config', 'app.yml')
    namespace Rails.env
  end
end
