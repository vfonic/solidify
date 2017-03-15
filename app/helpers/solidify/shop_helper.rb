module Solidify
  module ShopHelper
    def shop_settings
      @shop_settings ||= Setting.get_all
    end
  end
end
