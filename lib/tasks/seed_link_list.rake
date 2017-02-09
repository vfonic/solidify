namespace :solidus_liquid do
  namespace :link_list do
    desc 'seed link list'
    task seed: :environment do
      SolidusLiquid::LinkListSeeder.new.seed
    end
  end
end
