RSpec.shared_examples 'handle' do
  def factory_name
    described_class.name.demodulize.downcase.to_sym
  end

  describe 'friendly_id :name, use: [:finders, :slugged], slug_column: :slug' do
    it 'creates friendly id from :name attribute' do
      record = create(factory_name, name: 'This is the title')

      expect(record.slug).to eq('this-is-the-title')
    end

    it "does not update the slug when existing record's title changes" do
      record = create(factory_name, name: 'This is the title')

      record.update_attributes(name: 'New title')

      expect(record.slug).to eq('this-is-the-title')
    end

    it 'uses ActiveRecord.find method to search by slug' do
      record = create(factory_name, name: 'This is the title')

      expect(described_class.find('this-is-the-title')).to eq(record)
    end
  end

  describe '.handle_to_records_array' do
    it 'creates handle => records mapping' do
      record1 = create(factory_name, handle: 'Wow')
      record2 = create(factory_name, handle: 'Wat')

      expect(described_class.handle_to_records_array.keys).to eq(%w(Wow Wat))
      expect(described_class.handle_to_records_array['Wow']).to eq(record1)
      expect(described_class.handle_to_records_array['Wat']).to eq(record2)
    end
  end

  describe '#url' do
    it 'responds to #url' do
      expect(described_class.new).to respond_to(:url)
    end
  end

  it 'responds to :slug' do
    record = described_class.new
    record.slug = 'asd'

    expect(record.slug).to eq('asd')
  end

  it 'aliases :handle to :slug' do
    record = described_class.new
    allow(record).to receive(:slug=).and_call_original

    record.handle = 'dsa'

    expect(record).to have_received(:slug=).with('dsa')
  end

  it 'responds to :name' do
    record = described_class.new
    record.name = 'asd'

    expect(record.name).to eq('asd')
  end

  it 'aliases :title to :name' do
    record = described_class.new
    allow(record).to receive(:name=).and_call_original

    record.title = 'asd'

    expect(record).to have_received(:name=).with('asd')
  end
end
