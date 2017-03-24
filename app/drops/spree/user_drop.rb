module Spree
  class UserDrop < ::Liquid::Rails::Drop
    include ::Solidify::FullName

    attributes :id, :default_address, :email, :first_name, :last_name, :name,
               :password

    has_many :addresses

    def accepts_marketing
      false
    end

    def addresses_count
      @object.addresses.size
    end

    def errors
      Solidify::ErrorsDrop.new(@object.errors)
    end

    # rubocop:disable Style/PredicateName
    def has_account
      true
    end
    # rubocop:enable Style/PredicateName

    def last_order
      @object.orders.complete.by_completed_at.last
    end

    def orders
      @object.orders.complete
    end

    def orders_count
      @object.orders.complete.size
    end

    def password_needed
      true
    end

    def tags; end

    def total_spent
      0
    end

    def to_json(_json)
      { "error": 'json not allowed for this object' }.to_json
    end
  end
end
