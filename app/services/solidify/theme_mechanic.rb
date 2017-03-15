module Solidify
  class ThemeMechanic
    def initialize(
      name: 'Simple',
      path: Solidify::Engine.root.join(
        'app', 'views', 'solidify', 'themes', 'skeleton-theme'
      ),
      skip_file_upload: false
    )
      @name = name
      @path = path
      @skip_file_upload = skip_file_upload
    end

    def create
      theme = Theme.new(name: @name)

      files = Dir.glob("#{@path}/**/*")
      instantiate_assets_from_files(files, theme)

      theme.save!
      theme
    end

    def instantiate_assets_from_files(files, theme)
      files.each do |file|
        next if Dir.exist?(file) # skip directories
        theme.assets << asset_from_file(file)
      end
    end

    def asset_from_file(file)
      asset = Asset.new(key: Pathname.new(file).relative_path_from(@path).to_s)
      if @skip_file_upload
        asset.file = File.basename(file)
      else
        File.open(file) do |f|
          asset.file = f
        end
      end

      asset
    end
  end
end
