RSpec.shared_examples 'address' do
  describe '#street' do
    context 'both address1 and address2 not present' do
      it 'returns empty string' do
        record = described_class.new

        expect(record.street).to eq('')
      end
    end

    context 'address1 present' do
      it 'returns address1' do
        record = described_class.new(address1: ' address1 ')

        expect(record.street).to eq(' address1 ')
      end
    end

    context 'address2 preset' do
      it 'returns address2' do
        record = described_class.new(address2: ' address2 ')

        expect(record.street).to eq(' address2 ')
      end
    end

    context 'address1 and address2 present' do
      it 'returns combined address1 and address2' do
        address1 = ' address1 '
        address2 = ' address2 '
        record = described_class.new(address1: address1, address2: address2)

        expect(record.street).to eq("#{address1}, #{address2}")
      end
    end
  end
end
