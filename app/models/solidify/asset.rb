module Solidify
  class Asset < ActiveRecord::Base
    mount_uploader :file, AssetUploader
    belongs_to :theme

    before_save :postprocess_asset

    def postprocess_asset
      AssetPostprocessor.new(self).process if file_changed?
    end
  end
end
