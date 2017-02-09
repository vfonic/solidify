module SolidusLiquid
  class LinkDrop < ::Liquid::Rails::Drop
    attributes :title, :url

    belongs_to :link_list

    def active
      false
    end

    def type
      nil
    end
  end
end
