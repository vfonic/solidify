module Spree
  User.class_eval do
    include ::SolidusLiquid::FullName
  end
end
