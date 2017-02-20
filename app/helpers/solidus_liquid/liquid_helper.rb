module SolidusLiquid
  module LiquidHelper
    CONTROLLER_ACTION_TO_LIQUID_MAPPING = {
      'addresses#index' => 'templates/customers/addresses.liquid', # TODO implement
      'home#missing' => 'templates/404.liquid', # TODO implement
      'articles#show' => 'templates/article.liquid', # TODO implement
      # TODO: add blog.grid.liquid
      'blogs#show' => 'templates/blog.liquid', # TODO implement
      'carts#show' => 'templates/cart.liquid',
      # TODO: add activate_account.liquid
      'customers#show' => 'templates/customers/account.liquid', # TODO implement
      'collections#index' => 'templates/list-collections.liquid', # TODO implement
      # TODO; add collection.list.liquid
      'collections#show' => 'templates/collection%{template_suffix}.liquid', # TODO implement
      'home#index' => 'templates/index.liquid',
      'pages#show' => 'templates/page%{template_suffix}.liquid', # TODO implement
      'products#show' => 'templates/product.liquid',
      'registrations#new' => 'templates/customers/register.liquid', # TODO implement
      'search#index' => 'templates/search.liquid', # TODO implement
      'sessions#new' => 'templates/customers/login.liquid'
    }.freeze

    def content_for_header
      ApplicationController.new.render_to_string(
        template: 'solidus_liquid/global/content_for_header',
        layout: false
      )
    end

    def theme
      active_theme_id = request.cookies['active_theme_id']
      active_theme_id ||= cookies.try(:[], 'active_theme_id')
      @theme ||= Theme.find(active_theme_id)
    end

    def theme_dir
      "themes/#{theme.id}"
    end

    def theme_layout_file
      "../#{theme_dir}/layout/theme"
    end

    # rubocop:disable Metrics/MethodLength
    def liquid_assigns
      shop = shop_settings.merge({
        'collections_count' => Spree::Taxon.count,
        'locale' => I18n.locale.to_s,
        'permanent_domain' => shop_settings[:domain],
        'products_count' => Spree::Product.available.count,
        'secure_url' => "https://#{shop_settings[:domain]}",
        'types' => [],
        'url' => "https://#{shop_settings[:domain]}",
        'vendors' => []
      })

      {
        'cart' => current_customer.try(:cart) || find_order_by_token_or_user,
        'collections' => Spree::TaxonDrop.new(Spree::Taxon.all.to_a),
        'content_for_header' => content_for_header,
        'current_page' => 1,
        'current_tags' => nil,
        'customer' => current_customer,
        'linklists' => LinkList.handle_to_link_list,
        'page_description' => nil,
        'pages' => Page.handle_to_link_list,
        'powered_by_link' =>
          %(<a target="_blank" rel="nofollow" href="https://www.splitshop.com">
              Powered by Split
            </a>),
        'search' => Search.new,
        'settings' => theme_settings,
        'shop' => shop
      }
    end
    # rubocop:enable Metrics/MethodLength

    def theme_settings
      @theme_settings ||= JSON.parse(Redis.current.get("solidus_liquid_themes_#{theme.id}"))
    end

    def liquid_filters
      [AdditionalFilters, HtmlFilters, MoneyFilters, StringFilters, UrlFilters]
    end

    def set_active_theme
      cookies['active_theme_id'] ||= shop_settings['active_theme_id']
      theme
    end

    def controller_action_to_liquid_file_path(
      record = nil, controller_action = nil
    )
      # TODO: fallback to default template when template_suffix template missing
      template_suffix = record.try(:template_suffix)
      template_suffix = ".#{template_suffix}" if template_suffix.present?

      controller_action ||= "#{controller_name}##{action_name}"
      template_format =
        CONTROLLER_ACTION_TO_LIQUID_MAPPING.fetch(controller_action)

      template_path = template_format % ({ template_suffix: template_suffix })

      "#{theme_dir}/#{template_path}"
    end
  end
end
