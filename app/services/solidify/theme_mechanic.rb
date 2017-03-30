module Solidify
  class ThemeMechanic
    def self.create(name: 'Simple',
                    path: Solidify::Engine.root.join(
                      'app', 'views', 'solidify', 'themes', 'skeleton-theme'
                    ))
      theme = Theme.new(name: name)

      files = Dir.glob("#{path}/**/*")
      instantiate_assets_from_files(path, files, theme)

      theme.save!
      theme
    end

    def self.instantiate_assets_from_files(path, files, theme)
      files.each do |file|
        next if Dir.exist?(file) # skip directories
        theme.assets << asset_from_file(path, file)
      end
    end

    def self.asset_from_file(path, file)
      Asset.new(
        key: Pathname.new(file).relative_path_from(path).to_s,
        file: File.open(file)
      )
    end
  end
end
