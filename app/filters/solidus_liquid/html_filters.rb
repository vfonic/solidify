module SolidusLiquid
  module HtmlFilters
    def img_tag(url, alt = '')
      %(<img src="#{url}" alt="#{alt}" />)
    end

    def link_to(link, url, title = '')
      %(<a href="#{url}" title="#{title}">#{link}</a>)
    end

    def script_tag(url)
      %(<script src="#{url}" type="text/javascript"></script>)
    end

    def stylesheet_tag(url, media = 'all')
      %(<link href="#{url}" rel="stylesheet" type="text/css"  media="#{media}" />)
    end
  end
end
