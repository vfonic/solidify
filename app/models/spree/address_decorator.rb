module Spree
  Address.class_eval do
    extend Solidify::ValidationCancel
    cancel_validates :country_id

    has_many :user_addresses, -> { active }
    has_many :users, through: :user_addresses

    def postal_code_validate; end

    alias_attribute :country, :country_name
  end
end
