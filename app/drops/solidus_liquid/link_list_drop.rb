module SolidusLiquid
  class LinkListDrop < ::Liquid::Rails::Drop
    attributes :id, :title, :handle

    has_many :links
  end
end
