module SolidusLiquid
  class LinkListSeeder
    # rubocop:disable Metrics/MethodLength
    def seed
      LinkList.create(
        [
          {
            title: 'Main menu',
            handle: 'main-menu',
            links: [
              Link.new(title: 'Home', url: '/'),
              Link.new(title: 'Catalog', url: '/collections/all')
            ]
          },
          {
            title: 'Footer',
            handle: 'footer',
            links: [
              Link.new(title: 'Search', url: '/search')
            ]
          }
        ]
      )
    end
  end
end
