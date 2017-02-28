RSpec.shared_examples 'full_name' do
  describe '#name' do
    it 'returns full name' do
      record = described_class.new(first_name: 'Viktor', last_name: 'Fonic')

      expect(record.name).to eq('Viktor Fonic')
    end

    it 'returns first_name when last_name is not set' do
      record = described_class.new(first_name: 'Viktor')

      expect(record.name).to eq('Viktor')
    end

    it 'returns last_name when first_name is not set' do
      record = described_class.new(last_name: 'Fonic')

      expect(record.name).to eq('Fonic')
    end

    it 'returns empty string when first_name and last_name are not set' do
      record = described_class.new

      expect(record.name).to eq('')
    end
  end
end
