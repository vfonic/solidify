module Liquor
  class AssetUploader < ::CarrierWave::Uploader::Base
    def store_dir
      asset_file_dir = model.key.split('/')[-2]
      "themes/#{model.theme_id}/#{asset_file_dir}"
    end
  end
end
