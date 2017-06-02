module Solidify
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      def add_migrations
        run 'rails railties:install:migrations'
      end

      def run_migrations
        run 'rails db:migrate'
      end

      def install_routes
        insert_into_file(File.join('config', 'routes.rb'),
                         after: "Rails.application.routes.draw do\n") do
          <<~ROUTES
            # Setup Solidify's routes
            mount Solidify::Engine, at: '/'
          ROUTES
        end
      end
    end
  end
end
