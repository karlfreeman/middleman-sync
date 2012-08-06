require 'middleman-core/cli'

module Middleman
  module Cli
    # This class provides a "sync" command for the middleman CLI.
    class Sync < Thor
      include Thor::Actions

      #
      check_unknown_options!

      #
      namespace :sync

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "sync", "Build and sync"
      def sync
        shared_instance = ::Middleman::Application.server.inst
        
        # This only exists when the config.rb sets it!
        if shared_instance.respond_to? :sync
          # Run sync
        else
          raise Thor::Error.new "You need to activate the sync extension in config.rb before you can sync"
        end
      end
    end
  end
end
