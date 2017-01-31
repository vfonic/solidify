module Liquor
  class LiquidController < ApplicationController
    include Liquor::Liquid

    def set_liquid_assigns
      raise 'Need to call this from subclass'
    end
  end
end
