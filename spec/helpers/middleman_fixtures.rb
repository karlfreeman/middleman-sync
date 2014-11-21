require 'middleman-core'

module Middleman
  module Helpers
    module Fixtures
      #
      def fixtures_root
        File.expand_path(File.join(File.dirname(__FILE__), '../', 'fixtures', 'middleman'))
      end

      # Graciously cribbed from https://github.com/middleman/middleman/issues/737#issuecomment-14122832
      def middleman_app(fixture)
        fixture_root_dir = File.join(fixtures_root, fixture)
        File.exist?(File.join(fixture_root_dir, 'source')) ? ENV['MM_SOURCE'] = 'source' : ENV['MM_SOURCE'] = ''

        initialize_commands = @initialize_commands || []
        initialize_commands.unshift lambda {
          set :root, fixture_root_dir
          set :environment, :develop
          set :show_exceptions, false
        }

        ::Middleman::Application.server.inst do
          initialize_commands.each do |p|
            instance_exec(&p)
          end
        end
      end

      def middleman_cli(fixture)
        fixture_root_dir = File.join(fixtures_root, fixture)
        ENV['MM_ROOT'] = fixture_root_dir

        require 'middleman-core/profiling'
        require 'middleman-core/load_paths'
        Middleman.setup_load_paths

        require 'middleman-core/cli'
        Dir.chdir(ENV['MM_ROOT'])
        Middleman::Cli::Base.new
      end
    end
  end
end
