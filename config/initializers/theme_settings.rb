if SolidusLiquid::Theme.table_exists?
  SolidusLiquid::Theme.all.each do |theme|
    settings_file = Rails.root.join(
      'app', 'views', 'themes', theme.id.to_s, 'config', 'settings_data.json'
    )
    next unless settings_file.exist?
    settings_data = JSON.parse(
      File.read(settings_file)
    )
    if settings_data['current'].is_a? String
      settings = settings_data['presets'][settings_data['current']].to_json
    else
      settings = settings_data['current'].to_json
    end
    Redis.current.set("solidus_liquid_themes_#{theme.id}", settings)
  end
end

settings_file = SolidusLiquid::Engine.root.join(
  'app', 'views', 'solidus_liquid', 'themes', 'skeleton-theme', 'config', 'settings_data.json'
)
settings_data = JSON.parse(File.read(settings_file))
if settings_data['current'].is_a? String
  settings = settings_data['presets'][settings_data['current']].to_json
else
  settings = settings_data['current'].to_json
end
Redis.current.set("solidus_liquid_themes_", settings)
