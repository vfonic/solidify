module Solidify
  class PageDrop < ::Liquid::Rails::Drop
    attributes :id, :title, :body_html, :published_at, :author

    alias content body_html
  end
end
