module Liquor
  class Theme < ActiveRecord::Base
    has_many :assets

    def settings
      JSON.parse(Redis.current.get("themes_#{id}"))
    end

    def previewable
      true
    end

    def processing
      false
    end
  end
end
