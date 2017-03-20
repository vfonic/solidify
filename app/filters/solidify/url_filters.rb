module Solidify
  module UrlFilters
    GLOBAL_ASSET_URLS = {
      'social/social-icons.css' =>
        'https://solidify.s3.amazonaws.com/global/social/font-awesome.min.css',
      'shopify_common.js' =>
        'https://solidify.s3.amazonaws.com/global/shopify_common.js',
      'option_selection.js' =>
        'https://solidify.s3.amazonaws.com/global/option_selection.js'
    }.freeze

    def asset_url(asset_name)
      theme = @context.registers[:theme]
      'https://' + ENV.fetch('AWS_S3_BUCKET_NAME') +
        ".s3.amazonaws.com/themes/#{theme.id}/assets/#{asset_name}"
    end

    def customer_login_link(text)
      link_to(text, '/account/login')
    end

    def customer_logout_link(text)
      link_to(text, '/account/logout')
    end

    def customer_register_link(text)
      link_to(text, '/account/register')
    end

    def global_asset_url(asset_name)
      GLOBAL_ASSET_URLS[asset_name]
    end

    alias shopify_asset_url global_asset_url

    def img_url(drop, _size)
      case drop
      when ::Spree::ProductDrop
        drop.featured_image.try(:attachment).try(:url)
      when ::Spree::ImageDrop
        drop.attachment.url
      else
        drop.to_s
      end
    end

    def link_to(link, url, title = '')
      %(<a href="#{url}" title="#{title}">#{link}</a>)
    end

    def url_for_vendor(vendor)
      "/collections/vendors?q=#{vendor}"
    end

    def within(product_url, collection)
      "/collections/#{collection.handle}#{product_url}"
    end
  end
end
