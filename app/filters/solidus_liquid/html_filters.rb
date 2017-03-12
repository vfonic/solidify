module SolidusLiquid
  module HtmlFilters
    def img_tag(url, alt = '')
      %(<img src="#{url}" alt="#{alt}" />)
    end

    def script_tag(url)
      %(<script src="#{url}" type="text/javascript"></script>)
    end

    # rubocop:disable Metrics/LineLength
    def stylesheet_tag(url, media = 'all')
      %(<link href="#{url}" rel="stylesheet" type="text/css" media="#{media}" />)
    end
  end
end
