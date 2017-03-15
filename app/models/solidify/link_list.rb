module Solidify
  class LinkList < ActiveRecord::Base
    include Solidify::Handle

    has_many :links
  end
end
