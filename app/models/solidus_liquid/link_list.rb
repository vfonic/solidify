module SolidusLiquid
  class LinkList < ActiveRecord::Base
    include SolidusLiquid::Handle

    has_many :links
  end
end
