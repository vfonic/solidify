module SolidusLiquid
  class LinkList < ActiveRecord::Base
    has_many :links

    def self.handle_to_link_list
      LinkList.includes(:links).all.inject({}) do |hash, ll|
        hash.merge(ll.handle => ll)
      end
    end
  end
end
