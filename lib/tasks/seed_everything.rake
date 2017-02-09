namespace :solidus_liquid do
  namespace :shop do
    desc 'Seed default theme and shop settings from solidus_liquid gem'
    task seed_everything: :environment do
      theme = SolidusLiquid::ThemeMechanic.new.create

      SolidusLiquid::ShopSettingsSeeder.new(theme.id).seed

      SolidusLiquid::LinkListSeeder.new.seed
    end
  end
end
