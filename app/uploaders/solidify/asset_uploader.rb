module Solidify
  class AssetUploader < ::CarrierWave::Uploader::Base
    def store_dir
      asset_file_dir = model.key.split('/')
      asset_file_dir.pop
      asset_file_dir = asset_file_dir.join('/')
      "themes/#{model.theme_id}/#{asset_file_dir}"
    end
  end
end
