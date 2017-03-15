namespace :solidify do
  namespace :link_list do
    desc 'seed link list'
    task seed: :environment do
      Solidify::LinkListSeeder.new.seed
    end
  end
end
