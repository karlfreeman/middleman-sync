require "middleman-core"

module Middleman

  module Sync

    OPTION_KEYS = [:prefix, :public_path, :fog_provider, :fog_directory, :fog_region, :aws_access_key_id, :aws_secret_access_key, :rackspace_username, :rackspace_api_key, :rackspace_auth_url, :google_storage_secret_access_key, :google_storage_access_key_id, :after_build, :existing_remote_files, :gzip_compression, :ignored_files].freeze
    class Options < Struct.new(*OPTION_KEYS); end

    class << self

      def options
        @@sync_options
      end

      def registered(app, options_hash={}, &block)
        require "asset_sync"

        options = Options.new
        OPTION_KEYS.each do |option|
          options.send("#{option}=", options_hash[option]) if options_hash.keys.include?(option)
        end

        yield options if block_given?
        @@sync_options = options

        app.send :include, Helpers

        app.after_configuration do

          options.prefix ||= "**"
          options.public_path ||= build_dir
          options.ignored_files ||= []

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
            config.gzip_compression = !!options.gzip_compression
            config.ignored_files = options.ignored_files
            config.log_silently = false
          end

        end

        app.after_build do |builder|
          ::AssetSync.sync if options.after_build
        end

      end

      alias :included :registered

    end

    module Helpers

      def sync_options
        ::Middleman::Sync.options
      end

    end

  end

end
