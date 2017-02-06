module SolidusLiquid
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=solidus_liquid'
      end

      def run_migrations
        run 'bundle exec rake db:migrate'
      end
    end
  end
end
