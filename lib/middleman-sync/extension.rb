require "middleman-core"

module Middleman

  module Sync

    class Options < Struct.new(:prefix, :public_path, :fog_provider, :fog_directory, :fog_region, :aws_access_key_id, :aws_secret_access_key, :rackspace_username, :rackspace_api_key, :rackspace_auth_url, :google_storage_secret_access_key, :google_storage_access_key_id, :after_build, :existing_remote_files); end

    class << self

      def options
        @@options
      end

      def registered(app, options_hash={}, &block)
        require 'asset_sync'
        ENV["RAILS_GROUPS"] = "assets"

        options = Options.new(options_hash)
        yield options if block_given?
        
        @@options = options

        app.send :include, Helpers

        app.after_configuration do

          options.after_build ||= false
          options.prefix = "*"
          options.public_path = build_dir

          AssetSync.configure do |config|
            config.enabled = true
            config.prefix = options.prefix
            config.public_path = options.public_path
            config.fog_region = options.fog_region
            config.fog_provider = options.fog_provider
            config.fog_directory = options.fog_directory
            config.aws_access_key_id = options.aws_access_key_id
            config.aws_secret_access_key = options.aws_secret_access_key
            config.rackspace_username = options.rackspace_username
            config.rackspace_api_key = options.rackspace_api_key
            config.rackspace_auth_url = options.rackspace_auth_url
            config.google_storage_secret_access_key = options.google_storage_secret_access_key
            config.google_storage_access_key_id = options.google_storage_access_key_id
            config.existing_remote_files = options.existing_remote_files if options.existing_remote_files
          end

          after_build do |builder|
            ::AssetSync.sync if options.after_build
          end

        end

      end

      alias :included :registered

    end

    module Helpers
      
      def options
        ::Middleman::Sync.options
      end

    end

  end

end
