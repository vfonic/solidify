module Spree
  RSpec.describe ImageDrop do
    let(:assigns) { { 'image' => image } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'image', ImageFields::METHODS
  end
end
