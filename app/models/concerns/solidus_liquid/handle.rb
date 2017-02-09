module SolidusLiquid
  module Handle
    extend ActiveSupport::Concern
    include ActionDispatch::Routing::PolymorphicRoutes
    include Rails.application.routes.url_helpers

    included do
      extend FriendlyId
      friendly_id :title, use: [:finders, :slugged], slug_column: :handle


      def self.handle_to_link_list
        self.all.inject({}) do |hash, record|
          hash.merge(record.handle => record)
        end
      end

      def url
        polymorphic_path(self)
      end
    end
  end
end
