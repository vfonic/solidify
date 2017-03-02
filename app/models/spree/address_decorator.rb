module Spree
  Address.class_eval do
    extend SolidusLiquid::ValidationCancel
    cancel_validates :country_id
    include ::SolidusLiquid::Address
    include ::SolidusLiquid::FullName

    has_many :user_addresses, -> { active }
    has_many :users, through: :user_addresses

    def default
      user_addresses.first.try(:default)
    end

    def postal_code_validate; end

    alias_attribute :country, :country_name
    alias_attribute :province, :state_name
    alias_attribute :province_code, :state_code
    alias_attribute :zip, :zipcode
  end
end
