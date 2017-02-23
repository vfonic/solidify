module SolidusLiquid
  # rubocop:disable Metrics/BlockLength
  FactoryGirl.define do
    factory :asset, class: Asset do
      theme_id 1
      key 'simple'
      file do
        Rack::Test::UploadedFile.new(
          File.join(
            SolidusLiquid::Engine.root, 'spec', 'data', 'simple.liquid'
          )
        )
      end

      trait :javascript do
        key 'assets/shop.js.liquid'
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              SolidusLiquid::Engine.root, 'spec', 'data', 'assets', 'shop.js.liquid'
            )
          )
        end
      end

      trait :snippet do
        key 'snippets/open-graph-tags.liquid'
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              SolidusLiquid::Engine.root, 'spec', 'data', 'snippets', 'open-graph-tags.liquid'
            )
          )
        end
      end

      trait :stylesheet_liquid do
        key 'assets/style.scss.liquid'
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              SolidusLiquid::Engine.root, 'spec', 'data', 'assets', 'style.scss.liquid'
            )
          )
        end
      end

      trait :stylesheet_liquid_with_asset_url do
        key 'assets/style_with_asset_url_filter.scss.liquid'
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              SolidusLiquid::Engine.root, 'spec', 'data', 'assets',
              'style_with_asset_url_filter.scss.liquid'
            )
          )
        end
      end

      trait :stylesheet_scss do
        key 'assets/style.scss'
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              SolidusLiquid::Engine.root, 'spec', 'data', 'assets', 'style.scss'
            )
          )
        end
      end

      trait :stylesheet_scss_css do
        key 'assets/style.scss.css'
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              SolidusLiquid::Engine.root, 'spec', 'data', 'assets', 'style.scss.css'
            )
          )
        end
      end
    end
  end
end
