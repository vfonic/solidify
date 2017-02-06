module SolidusLiquid
  class Theme < ActiveRecord::Base
    has_many :assets

    def settings
      settings = Redis.current.get("solidus_liquid_themes_#{id}")
      settings ||= Redis.current.get('solidus_liquid_themes_')
      JSON.parse(settings)
    end

    def previewable
      true
    end

    def processing
      false
    end
  end
end
