module Spree
  RSpec.describe VariantDrop do
    let(:variant_attributes) do
      {
        id: 4
      }
    end

    let(:assigns) { { 'variant' => variant } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'variant', VariantFields::METHODS
  end
end
