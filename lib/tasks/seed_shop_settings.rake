namespace :solidify do
  namespace :shop_settings do
    desc 'seed default shop settings'
    task seed: :environment do
      Solidify::ShopSettingsSeeder.new(1).seed
    end
  end
end
