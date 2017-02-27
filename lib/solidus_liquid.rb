require 'solidus_core'
require 'solidus_auth_devise'
require 'solidus_liquid/configuration'
require 'solidus_liquid/version'
require 'carrierwave'
require 'devise'
require 'solidus_liquid/engine'
require 'liquid-rails'
require 'rails-settings-cached'
require 'redis'
require 'sass'

require "set"
require "zlib"
require "active_support/core_ext/module/attribute_accessors"
require 'active_record/errors'

module ActiveRecord
  class Migration
    class << self
      # Raises <tt>ActiveRecord::PendingMigrationError</tt> error if any migrations are pending.
      def check_pending!(connection = Base.connection)
        if ActiveRecord::Migrator.needs_migration?(connection)
          raise StandardError.new(
            "Migrations are pending. To resolve this issue, run:\n\n        bin/rails db:migrate RAILS_ENV=#{::Rails.env}\n\n\
            Missing migrations: #{ActiveRecord::Migrator.missing_migrations}\n\n"
          )
        end
      end
    end
  end

  class Migrator#:nodoc:
    class << self
      def missing_migrations(connection = Base.connection)
        migrations(migrations_paths).collect(&:version) - get_all_versions(connection)
      end
    end
  end
end
