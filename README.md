# Solidus Liquid

Rails meets Shopify liquid theme files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'solidus_liquid'
```

And then execute:

    $ bundle install

## Usage

First run:

```ruby
rails generate solidus_liquid:install
```

...to get the necessary migrations into your app.

SolidusLiquid uses redis to manage Shop and Theme settings. To load the settings, create a new initializer in `config/initializers`:

```ruby
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
```

Add this gem to your `Gemfile` until I publish it:
```ruby
gem 'liquid-rails', github: 'vfonic/liquid-rails'
```

Add these ENV variables so that Carrierwave gem can store your theme files to S3:

```yaml
AWS_ACCESS_KEY_ID: ''
AWS_SECRET_ACCESS_KEY: ''
AWS_S3_REGION: 'us-east-1'
AWS_S3_BUCKET_NAME: 'solid5-shop'
```

From rails console run `SolidusLiquid::ThemeMechanic.new.create` to seed the database.

Run `rake solidus_liquid:theme:download_all_themes` to download theme files.

[MIT License](http://opensource.org/licenses/MIT)
