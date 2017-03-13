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
      it_behaves_like 'filter', 'fruits', 'join' do
        let(:expected) { 'apple orange banana' }
      end

      context 'with params' do
        it_behaves_like 'filter', 'fruits', 'join', '","' do
          let(:expected) { 'apple,orange,banana' }
        end
      end
    end

    describe '#first' do
      it_behaves_like 'filter', 'fruits', 'first' do
        let(:expected) { 'apple' }
      end
    end

    describe '#last' do
      it_behaves_like 'filter', 'fruits', 'last' do
        let(:expected) { 'banana' }
      end
    end

    describe '#concat' do
      it_behaves_like 'filter', 'fruits', 'concat', 'vegetables' do
        let(:expected) { 'apple orange banana potato kale spinach'.delete(' ') }
      end
    end

    describe '#index' do
      let(:template) { '{{ fruits[2] }}' }

      it 'returns correct result' do
        expect(subject).to eq('banana')
      end
    end

    describe '#map' do
      let(:variant1) do
        build(:base_variant,
              option_values: [
                build(:option_value, presentation: 'Depressed'),
                build(:option_value, presentation: 'Green eyes')
              ])
      end
      let(:variant2) do
        build(:base_variant,
              option_values: [
                build(:option_value, presentation: 'Two Heads'),
                build(:option_value, presentation: 'President')
              ])
      end
      let(:assigns) { { 'variants' => [variant1, variant2] } }

      it_behaves_like 'filter', 'variants', 'map', '"title"' do
        let(:expected) { 'Depressed / Green eyes' + 'Two Heads / President' }
      end
    end

    describe '#reverse' do
      it_behaves_like 'filter', 'fruits', 'reverse' do
        let(:expected) { 'apple orange banana'.split(' ').reverse.join }
      end
    end

    describe '#size' do
      it_behaves_like 'filter', 'fruits', 'size' do
        let(:expected) { '3' }
      end
    end

    describe '#slice' do
      it_behaves_like('filter', 'fruits', 'slice', '0') do
        let(:expected) { 'apple' }
      end
      it_behaves_like('filter', 'fruits', 'slice', '1') do
        let(:expected) { 'orange' }
      end
      it_behaves_like('filter', 'fruits', 'slice', '1, 2') do
        let(:expected) { 'orange banana'.delete(' ') }
      end
      it_behaves_like('filter', 'fruits', 'slice', '-1, 1') do
        let(:expected) { 'banana' }
      end
    end

    describe '#sort' do
      let(:variant1) { build(:base_variant, price: 16.99) }
      let(:variant2) { build(:base_variant, price: 15.99) }
      let(:assigns) { { 'variants' => [variant1, variant2] } }

      it_behaves_like 'filter', 'variants', 'sort', '"price" | map: "price"' do
        let(:expected) { '1599' + '1699' }
      end
    end

    describe '#uniq' do
      let(:assigns) do
        { 'fruits' => %w(apple banana apples apple orange banana) }
      end

      it_behaves_like 'filter', 'fruits', 'uniq' do
        let(:expected) { 'apple banana apples orange'.delete(' ') }
      end
    end
  end
end
