module Liquor
  module LiquidHelper
    CONTROLLER_ACTION_TO_LIQUID_MAPPING = {
      # TODO: add 404.liquid
      'articles#show' => 'templates/article.liquid',
      # TODO: add blog.grid.liquid
      'blogs#show' => 'templates/blog.liquid',
      'carts#show' => 'templates/cart.liquid',
      # TODO: add activate_account.liquid
      'customers#show' => 'templates/customers/account.liquid',
      'collections#index' => 'templates/list-collections.liquid',
      # TODO; add collection.list.liquid
      'collections#show' => 'templates/collection%{template_suffix}.liquid',
      'home#index' => 'templates/index.liquid',
      'pages#show' => 'templates/page%{template_suffix}.liquid',
      'products#show' => 'templates/product.liquid',
      'registrations#new' => 'templates/customers/register.liquid',
      'search#show' => 'templates/search.liquid',
      'sessions#new' => 'templates/customers/login.liquid'
    }.freeze

    def content_for_header
      ApplicationController.new.render_to_string(
        template: 'liquor/global/content_for_header',
        layout: false
      )
    end

    def theme
      cookies = request.cookies unless cookies.present?
      @theme ||= Theme.find(cookies['active_theme_id'])
    end

    def theme_dir
      "themes/#{theme.id}"
    end

    def theme_layout_file
      "../#{theme_dir}/layout/theme"
    end

    # rubocop:disable Metrics/MethodLength
    def liquid_assigns
      {
        'cart' => current_customer.try(:cart) || Cart.new,
        'content_for_header' => content_for_header,
        'current_page' => 1,
        'current_tags' => nil,
        'customer' => current_customer,
        'linklists' => LinkList.handle_to_link_list,
        'page_description' => nil,
        'powered_by_link' =>
          %(<a target="_blank" rel="nofollow" href="https://www.splitshop.com">
              Powered by Split
            </a>),
        'search' => Search.new,
        'settings' => theme_settings,
        'shop' => shop_settings
      }
    end
    # rubocop:enable Metrics/MethodLength

    def shop_settings
      @shop_settings ||= Setting.get_all
    end

    def theme_settings
      @theme_settings ||= JSON.parse(Redis.current.get("themes_#{theme.id}"))
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
