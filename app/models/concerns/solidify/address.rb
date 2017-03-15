module Solidify
  module Address
    extend ActiveSupport::Concern

    included do
      def street
        if address1.present? && address2.present?
          "#{address1}, #{address2}"
        else
          address1 || address2 || ''
        end
      end
    end
  end
end
