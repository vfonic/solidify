module SolidusLiquid
  class Page < ActiveRecord::Base
    include SolidusLiquid::Handle
  end
end
