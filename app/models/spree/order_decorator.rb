module Spree
  Order.class_eval do
    scope :complete, -> { where(state: OrderState::COMPLETE) }
    scope :by_completed_at, -> { order(:completed_at) }
  end
end
