module Solidify
  class Link < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [:finders, :slugged], slug_column: :url

    belongs_to :link_list

    alias_attribute :title, :name
  end
end
