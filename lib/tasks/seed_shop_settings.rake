namespace :solidus_liquid do
  namespace :shop_settings do
    desc 'seed default shop settings'
    task seed: :environment do
      SolidusLiquid::ShopSettingsSeeder.new(1).seed
    end
  end
end
