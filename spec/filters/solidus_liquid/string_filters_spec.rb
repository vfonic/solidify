module SolidusLiquid
  RSpec.describe 'StringFilters', type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { Hash.new }
    let(:strict) { true }

    describe '#size' do
      let(:expected) { '6' }
      it_behaves_like 'filter', '"banana"', 'size'
    end
  end
end
