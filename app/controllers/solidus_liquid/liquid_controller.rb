module SolidusLiquid
  class LiquidController < ApplicationController
    include SolidusLiquid::Liquid

    def set_liquid_assigns
      raise 'Need to call this from subclass'
    end
  end
end
