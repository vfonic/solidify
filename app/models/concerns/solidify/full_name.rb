module Solidify
  module FullName
    extend ActiveSupport::Concern

    included do
      def name
        "#{first_name} #{last_name}".strip
      end
    end
  end
end
