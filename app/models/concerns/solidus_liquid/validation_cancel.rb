module SolidusLiquid
  module ValidationCancel
    def cancel_validates(*attributes)
      klass = self
      attributes.each do |attribute|
        cancel_single_validates(attribute, klass)
        cancel_array_validates(attribute)
      end
    end

    private

    def cancel_single_validates(attribute, klass)
      # validates :country_id, presence: true
      ary = [attribute]
      callbacks = _validate_callbacks.select do |callback|
        callback.raw_filter.try(:attributes) == ary
      end
      callbacks.each do |callback|
        ifs = callback.instance_variable_get(:@if)
        ifs << proc { !is_a?(klass) }
      end
    end

    def cancel_array_validates(attribute)
      # validates :firstname, :address1, :city, :country_id, presence: true
      callbacks = _validate_callbacks.select do |callback|
        callback.raw_filter.try(:attributes).try(:include?, attribute)
      end
      callbacks.map { |cb| cb.raw_filter.attributes.delete(attribute) }
    end
  end
end
