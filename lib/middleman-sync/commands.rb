require "middleman-core/cli"
require "middleman-sync/extension"

module Middleman

  module Cli

    class Sync < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :sync

      def self.exit_on_failure?
        true
      end

      desc "sync", "Synchronise your Middleman build to S3 and more"
      def sync

        shared_inst = ::Middleman::Application.server.inst

        after_build = shared_inst.options.after_build
        if (!after_build)
          raise Thor::Error.new "You need to activate the sync extension in config.rb"
        end

        ::AssetSync.sync

      end

    end

  end

end
