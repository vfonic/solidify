module SolidusLiquid
  class LinkListSeeder
    def seed
      LinkList.create(
      [
        {
          title: 'Main menu',
          handle: 'main-menu',
          links: [
            Link.new(title: 'Home', handle: '/'),
            Link.new(title: 'Catalog', handle: '/collections/all')
          ]
        },
        {
          title: 'Footer',
          handle: 'footer',
          links: [
            Link.new(title: 'Search', handle: '/search')
          ]
        }
      ]
    )
    end
  end
end
