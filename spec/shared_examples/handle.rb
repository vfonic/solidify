RSpec.shared_examples 'handle' do
  it 'responds to :handle'
  it 'responds to :slug'
  it 'responds to :title'
  it 'responds to :name'

  describe '#url'

  xdescribe '.handle_to_link_list' do
    it 'creates handle => links mapping' do
      create(:link_list, handle: 'footer', links: [
               build(:link, title: 'Home', url: '/'),
               build(:link, title: 'Catalog', url: '/collections/all')
             ])
      expect(LinkList.handle_to_link_list['footer'].links.count).to eq(2)
    end
  end
end
