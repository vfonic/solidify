module SolidusLiquid
  class LinkDrop < ::Liquid::Rails::Drop
    attributes :title, :url

    belongs_to :link_list

    def active
      @context.registers[:controller].request.path == @object.url
    end

    def type
      nil
    end
  end
end
