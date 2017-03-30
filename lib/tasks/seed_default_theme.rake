namespace :solidify do
  namespace :themes do
    desc 'Seed default skeleton-theme theme and assets from solidify gem'
    task seed_default_theme: :environment do
      Solidify::ThemeMechanic.create
    end
  end
end
