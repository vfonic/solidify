module SolidusLiquid
  class Link < ActiveRecord::Base
    belongs_to :link_list
  end
end
