module SolidusLiquid
  module Handle
    extend ActiveSupport::Concern

    included do
      extend FriendlyId
      friendly_id :title, use: [:finders, :slugged], slug_column: :handle


      def self.handle_to_link_list
        self.all.inject({}) do |hash, record|
          hash.merge(record.handle => record)
        end
      end
    end
  end
end
