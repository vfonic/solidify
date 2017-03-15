namespace :solidify do
  namespace :shop do
    desc 'Seed default theme and shop settings from solidify gem'
    task seed_everything: :environment do
      theme = Solidify::ThemeMechanic.new.create

      Solidify::ShopSettingsSeeder.new(theme.id).seed

      Solidify::LinkListSeeder.new.seed

      # TODO: seed default 'all' collection
    end
  end
end
