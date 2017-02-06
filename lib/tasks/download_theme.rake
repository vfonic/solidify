namespace :solidus_liquid do
  namespace :themes do
    desc 'Download active theme from AWS'
    task download_all_themes: :environment do
      assets = SolidusLiquid::Asset.all
      assets.each do |asset|
        puts "Downloading #{asset.key}"
        local_asset_path = Rails.root.join(
          'app', 'views', 'themes', asset.theme_id.to_s, asset.key
        )
        FileUtils.mkdir_p(File.dirname(local_asset_path))
        File.open(local_asset_path, 'wb') do |f|
          f.write(asset.file.read)
        end
      end
    end
  end
end
