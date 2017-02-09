module SolidusLiquid
  class Link < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: [:finders, :slugged], slug_column: :url

    belongs_to :link_list
  end
end
