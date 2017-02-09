module SolidusLiquid
  class Link < ActiveRecord::Base
    include SolidusLiquid::Handle

    belongs_to :link_list
  end
end
