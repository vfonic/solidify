namespace :solidus_liquid do
  namespace :themes do
    desc 'Download active theme from AWS'
    task seed_default_theme: :environment do
      SolidusLiquid::ThemeMechanic.new.create
    end
  end
end
