module SolidusLiquid
  module Handle
    extend ActiveSupport::Concern
    include ActionDispatch::Routing::PolymorphicRoutes
    include SolidusLiquid::Engine.routes.url_helpers

    included do
      extend FriendlyId
      friendly_id :name, use: [:finders, :slugged], slug_column: :slug


      def self.handle_to_records_array
        self.all.inject({}) do |hash, record|
          hash.merge(record.handle => record)
        end
      end

      def url
        polymorphic_path(self)
      end

      alias_attribute :handle, :slug
      alias_attribute :title, :name
    end
  end
end
