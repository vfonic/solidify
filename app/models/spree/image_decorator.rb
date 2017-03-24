module Spree
  Image.class_eval do
    def as_json(_options = {})
      attachment.url
    end
  end
end
