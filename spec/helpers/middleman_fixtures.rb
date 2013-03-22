module Middleman
  module Helpers
    module Fixtures

      #
      def fixtures_path
        File.join(File.expand_path(File.dirname(__FILE__)), '../', 'fixtures', 'middleman')
      end

      # Graciously cribbed from https://github.com/middleman/middleman/issues/737#issuecomment-14122832
      def middleman_app(fixture_path)
        root_dir = File.expand_path(self.fixtures_path, fixture_path)

        if File.exists?(File.join(root_dir, 'source'))
          ENV["MM_SOURCE"] = 'source'
        else
          ENV["MM_SOURCE"] = ""
        end

        initialize_commands = @initialize_commands || []
        initialize_commands.unshift lambda {
          set :root, root_dir
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