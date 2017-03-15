if Solidify::Theme.table_exists?
  Solidify::Theme.all.each do |theme|
    settings_file = Rails.root.join(
      'app', 'views', 'themes', theme.id.to_s, 'config', 'settings_data.json'
    )
    next unless settings_file.exist?
    settings_data = JSON.parse(
      File.read(settings_file)
    )
    settings = if settings_data['current'].is_a? String
                 settings_data['presets'][settings_data['current']].to_json
               else
                 settings_data['current'].to_json
               end
    Redis.current.set("solidify_themes_#{theme.id}", settings)
  end
end

settings_file = Solidify::Engine.root.join(
  'app', 'views', 'solidify', 'themes', 'skeleton-theme', 'config',
  'settings_data.json'
)
settings_data = JSON.parse(File.read(settings_file))
settings = if settings_data['current'].is_a? String
             settings_data['presets'][settings_data['current']].to_json
           else
             settings_data['current'].to_json
           end
Redis.current.set('solidify_themes_', settings)
