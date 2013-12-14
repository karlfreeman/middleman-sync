require 'middleman-core/cli'

module Middleman

  module Cli

    class Sync < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :sync

      def self.exit_on_failure?
        true
      end

      desc 'sync', 'Synchronise your Middleman build to S3 and more'
      def sync

        shared_inst = ::Middleman::Application.server.inst
        puts 'WIP'
        # ::MultiSync.run


      end

    end

  end

end
