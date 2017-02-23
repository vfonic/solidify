module SolidusLiquid
  # RailsSettings Model
  class Setting < ::RailsSettings::Base
    # self.table_name = "#{SolidusLiquid::Engine.engine_name}_settings"
    source Rails.root.join('config/app.yml')
    namespace Rails.env
  end
end
