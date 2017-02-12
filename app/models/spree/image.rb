module Spree
  class Image < Asset
    has_attached_file :attachment,
                      styles: {
                        pico:        '16x16',
                        icon:        '32x32',
                        thumb:       '50x50',
                        small:     '100x100',
                        compact:   '160x160',
                        medium:    '240x240',
                        large:     '480x480',
                        grande:    '600x600',
                        original: '1024x1024'
                      },
                      default_style: :product,
                      default_url: 'noimage/:style.png',
                      url: '/spree/products/:id/:style/:basename.:extension',
                      path: ':rails_root/public/spree/products/:id/:style/:basename.:extension',
                      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
  end
end
