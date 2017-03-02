module Spree
  class UserDrop < ::Liquid::Rails::Drop
    attributes :id, :default_address, :email, :first_name, :last_name, :name,
               :password
    has_many :orders
    has_many :addresses

    def accepts_marketing
      false
    end

    def addresses_count
      @object.addresses.count
    end

    def errors
      SolidusLiquid::ErrorsDrop.new(@object.errors)
    end

    # rubocop:disable Style/PredicateName
    def has_account
      true
    end
    # rubocop:enable Style/PredicateName

    def password_needed
      true
    end

    def tags; end

    def to_json(_json)
      { "error": 'json not allowed for this object' }.to_json
    end
  end
end
