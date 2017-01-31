module Liquor
  class LiquidController < ApplicationController
    include ::Concerns::Liquid

    def set_liquid_assigns
      raise 'Need to call this from subclass'
    end
  end
end
