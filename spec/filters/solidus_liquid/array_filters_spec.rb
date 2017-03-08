module SolidusLiquid
  RSpec.describe 'ArrayFilters', type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) do
      {
        'fruits' => %w(apple orange banana),
        'vegetables' => %w(potato kale spinach)
      }
    end
    let(:strict) { true }

    describe '#join' do
      let(:expected) { 'apple orange banana' }
      it_behaves_like 'filter', 'fruits', 'join'

      context 'with params' do
        let(:expected) { 'apple,orange,banana' }
        it_behaves_like 'filter', 'fruits', 'join', '","'
      end
    end

    describe '#first' do
      let(:expected) { 'apple' }
      it_behaves_like 'filter', 'fruits', 'first'
    end

    describe '#last' do
      let(:expected) { 'banana' }
      it_behaves_like 'filter', 'fruits', 'last'
    end

    describe '#concat' do
      let(:expected) { 'apple orange banana potato kale spinach'.delete(' ') }
      it_behaves_like 'filter', 'fruits', 'concat', 'vegetables'
    end

    describe '#index' do
      let(:expected) { 'banana' }
      let(:template) { '{{ fruits[2] }}' }

      it 'returns correct result' do
        expect(subject).to eq(expected)
      end
    end
  end
end
