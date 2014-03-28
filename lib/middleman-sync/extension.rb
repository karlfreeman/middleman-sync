require 'middleman-core'

module Middleman
  module Sync
    class Extension < Middleman::Extension
      # middleman-sync specific options
      # option :auto_source, true, 'automatically add Middleman\'s build folder as a local_source (defaults to true)'

      # multi_sync options
      option :verbose, nil, 'turn on verbose logging (defaults to false)'
      option :force, nil, 'force syncing of outdated_files (defaults to false)'
      option :run_on_build, nil, 'when within a framework which `builds` assets, whether to sync afterwards (defaults to true)'
      option :sync_outdated_files, nil, 'when an outdated file is found whether to replace it (defaults to true)'
      option :delete_abandoned_files, nil, 'when an abondoned file is found whether to remove it (defaults to true)'
      option :upload_missing_files, nil, 'when a missing file is found whether to upload it (defaults to true)'
      option :target_pool_size, nil, "how many threads you would like to open for each target (defaults to the amount of CPU core's your machine has)'"
      option :max_sync_attempts, nil, 'how many times a file should be retried if there was an error during sync (defaults to 3)'

      DEPRECATED_ASSET_SYNC_CREDENTIAL_OPTIONS = [:aws_access_key_id, :aws_secret_access_key, :rackspace_username, :rackspace_api_key, :rackspace_auth_url, :google_storage_access_key_id, :google_storage_secret_access_key, :path_style]
      DEPRECATED_ASSET_SYNC_OPTIONS = [:fog_provider, :fog_directory, :fog_region, :existing_remote_files, :gzip_compression, :after_build]
      DEPRECATED_OPTIONS = DEPRECATED_ASSET_SYNC_CREDENTIAL_OPTIONS | DEPRECATED_ASSET_SYNC_OPTIONS
      DEPRECATED_OPTIONS.each do |option_name|
        send(:option, option_name, nil)
      end

      require 'multi_sync' unless defined?(MultiSync)

      def initialize(app, options_hash = {}, &block)
        return unless app.environment == :build
        super

        opts = options.dup.to_h
        opts.delete_if { |k, v| v.nil? }

        app.after_configuration do

          # if opts.delete(:auto_source)
          #   MultiSync.prepare do
          #     local_source(source_dir: MultiSync::Extensions::Middleman.source_dir)
          #   end
          # end

          if DEPRECATED_OPTIONS.any? { |deprecated_option| opts.key?(deprecated_option) }
            MultiSync.warn 'Deprecated :sync options detected...'
            MultiSync.warn ':gzip_compression no longer supported' unless opts[:gzip_compression].nil?

            credentials = {}
            credentials[:region] = opts[:fog_region] unless opts[:fog_region].nil?
            DEPRECATED_ASSET_SYNC_CREDENTIAL_OPTIONS.each do |option|
              credentials[option] = opts[option] unless opts[option].nil?
            end

            MultiSync.prepare do
              send("#{opts[:fog_provider].to_s.downcase}_target", target_dir: opts[:fog_directory], credentials: credentials)
            end

            MultiSync.run_on_build = opts[:after_build] unless opts[:after_build].nil?

            case opts[:existing_remote_files]
            when 'delete'
              MultiSync.delete_abandoned_files = true
            when 'keep', 'ignore'
              MultiSync.delete_abandoned_files = false
            end

          end

          DEPRECATED_OPTIONS.each do |option_name|
            opts.delete(option_name)
          end

          opts.each do |key, value|
            MultiSync.send("#{key}=", value) unless value.nil?
          end
        end

        app.after_build do |builder|
          MultiSync.logger = Middleman::Cli::Build.shared_instance.logger
          MultiSync.status_logger = builder
          MultiSync.run if MultiSync.run_on_build
        end
      end
      alias_method :included, :initialize
    end

    module Sources
      # create methods for each source (local_source(options), manifest_source(options))
      MultiSync::Client::SUPPORTED_SOURCE_TYPES.each do |type, clazz|

        # get the class name (eg LocalSource)
        class_name = clazz.name.split('::').last

        # get the classes attributes
        clazz_attributes = clazz.attribute_set.map(&:name)

        # create a new Middleman::Extension for each one
        extension_meta_class = Class.new(Middleman::Extension) do
          self.supports_multiple_instances = true

          # TODO: HACK
          option :type, type

          # use the same attributes on the class as we do on the extension
          clazz_attributes.each do |attribute|
            send(:option, attribute, nil, '')
          end

          def initialize(app, options_hash = {}, &block)
            return unless app.environment == :build
            super
            opts = options.dup.to_h
            opts.delete_if { |k, v| v.nil? }
            # opts[:source_dir] ||= MultiSync::Extensions::Middleman.source_dir
            app.after_configuration do
              MultiSync.prepare do
                send("#{opts.delete(:type)}_source", opts)
              end
            end
          end
          alias_method :included, :initialize
        end

        # add the new extension to Middleman::Sync's Sources
        extension_class = Middleman::Sync::Sources.const_set(class_name, extension_meta_class)

        # register this extension to Middleman's registar
        Middleman::Extensions.register("#{type}_source".to_sym) do
          extension_class
        end

      end
    end

    module Targets
      # create methods for each source (local_target(options), aws_target(options))
      MultiSync::Client::SUPPORTED_TARGET_TYPES.each do |type, clazz|

        # get the class name (eg AwsTarget)
        class_name = clazz.name.split('::').last

        # get the classes attributes
        clazz_attributes = clazz.attribute_set.map(&:name)
        clazz_attributes.delete(:connection)

        # create a new Middleman::Extension for each one
        extension_meta_class = Class.new(Middleman::Extension) do
          self.supports_multiple_instances = true

          # TODO: HACK
          option :type, type

          # use the same attributes on the class as we do on the extension
          clazz_attributes.each do |attribute|
            send(:option, attribute, nil, '')
          end

          def initialize(app, options_hash = {}, &block)
            return unless app.environment == :build
            super
            opts = options.dup.to_h
            opts.delete_if { |k, v| v.nil? }
            app.after_configuration do
              MultiSync.prepare do
                send("#{opts.delete(:type)}_target", opts)
              end
            end
          end
          alias_method :included, :initialize
        end

        # add the new extension to Middleman::Sync's Sources
        extension_class = Middleman::Sync::Targets.const_set(class_name, extension_meta_class)

        # register this extension to Middleman's registar
        Middleman::Extensions.register("#{type}_target".to_sym) do
          extension_class
        end

      end
    end
  end
end
