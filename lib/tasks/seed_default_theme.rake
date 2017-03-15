namespace :solidify do
  namespace :themes do
    desc 'Seed default skeleton-theme theme and assets from solidify gem'
    task seed_default_theme: :environment do
      Solidify::ThemeMechanic.new.create
    end
  end
end
