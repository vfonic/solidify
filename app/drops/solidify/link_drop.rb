module Solidify
  class LinkDrop < ::Liquid::Rails::Drop
    attributes :title, :url

    belongs_to :link_list

    def active
      @context.registers[:view].current_page?(@object.url)
    end

    def type
      nil
    end
  end
end
