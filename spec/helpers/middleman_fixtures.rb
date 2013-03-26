module Middleman
  module Helpers
    module Fixtures

      #
      def fixtures_root
        File.expand_path(File.join(File.dirname(__FILE__), "../", "fixtures", "middleman"))
      end

      # Graciously cribbed from https://github.com/middleman/middleman/issues/737#issuecomment-14122832
      def middleman_app(fixture)
        fixture_root_dir = File.join(self.fixtures_root, fixture)
        File.exists?(File.join(fixture_root_dir, "source")) ? ENV["MM_SOURCE"] = "source" : ENV["MM_SOURCE"] = "" 

        initialize_commands = @initialize_commands || []
        initialize_commands.unshift lambda {
          set :root, fixture_root_dir
          set :environment, :development
          set :show_exceptions, false
        }

        Middleman::Application.server.inst do
          initialize_commands.each do |p|
            instance_exec(&p)
          end
        end

      end

    end
  end
end