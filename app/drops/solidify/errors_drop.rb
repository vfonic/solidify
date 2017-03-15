module Solidify
  class ErrorsDrop < ::Liquid::Rails::Drop
    attributes :messages

    def initialize(errors)
      @errors = errors
      super
    end

    def to_liquid
      @errors.full_messages
    end
  end
end
