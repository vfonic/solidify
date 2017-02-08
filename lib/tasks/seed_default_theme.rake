namespace :solidus_liquid do
  namespace :themes do
    desc 'Seed default skeleton-theme theme and assets from solidus_liquid gem'
    task seed_default_theme: :environment do
      SolidusLiquid::ThemeMechanic.new.create
    end
  end
end
