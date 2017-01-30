module Liquor
  module UrlFilters
    GLOBAL_ASSET_URLS = {
      'social/social-icons.css' =>
        'https://shopify-split.s3.amazonaws.com/global/social/social-icons.css',
      'shopify_common.js' =>
        'https://shopify-split.s3.amazonaws.com/global/shopify_common.js',
      'option_selection.js' =>
        'https://shopify-split.s3.amazonaws.com/global/option_selection.js'
    }.freeze

    def asset_url(asset_name)
      theme = @context.registers[:theme]
      'https://' + ENV.fetch('AWS_S3_BUCKET_NAME') +
        ".s3.amazonaws.com/themes/#{theme.id}/assets/#{asset_name}"
      "/assets/#{asset_name}"
    end

    def customer_login_link(text)
      link_to(text,
              Rails.application.routes.url_helpers.new_customer_session_path)
    end

    def customer_logout_link(text)
      link_to(text,
              Rails.application.routes.url_helpers.destroy_customer_session_path)
    end

    def customer_register_link(text)
      link_to(text,
              Rails.application.routes.url_helpers.new_customer_registration_path)
    end

    def global_asset_url(asset_name)
      GLOBAL_ASSET_URLS[asset_name]
    end

    alias shopify_asset_url global_asset_url
  end
end
