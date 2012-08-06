module Middleman
  module Sync

    class Options
      KEYS = [
        :enabled,
        :fog_provider,
        :fog_directory,
        :fog_region,
        :aws_access_key_id,
        :aws_secret_access_key,
        :prefix,
        :public_path
      ]
      
      KEYS.each do |name|
        attr_accessor name
      end
      
      def initialize(options={})
        options.each do |k,v|
          self.send(:"#{k}=", v)
        end
        self.enabled = true
        self.prefix = "build"
        self.public_path = "build"
      end

    end


    class << self

      def registered(app, options_hash={}, &block)
        require 'asset_sync'

        # options = Options.new(options_hash)
        # yield options if block_given?
        # ap options
        # ::AssetSync.configure(options)
        ENV["RAILS_GROUPS"] = "assets"
        AssetSync.configure(&block)

        app.after_configuration do
          after_build do |builder|
            AssetSync.sync 
            # ::Middleman::Sync.sync(build_dir, options, builder)
          end
        end

      end
      alias :included :registered

      # def sync(build_dir, options, builder = nil)

      #   storage = Fog::Storage.new(options.fog_options)

      #   prefix = build_dir + File::SEPARATOR
      #   directory = storage.directories.get('middleman-test')

      #   existant = directory.files.inject({}) do |hash, file|
      #     hash[file.key.sub(prefix, "")] = file.etag
      #     hash
      #   end

      #   files = Dir.glob("#{build_dir}/**/**").select { |f| File.file?(f) }
      #   files[0...2].each do |f|
          
      #     body = File.read f, :open_args => ['rb']
      #     digest = Digest::MD5.new
      #     digest.update(body)

      #     if existant[f.sub(prefix, "")] == digest.hexdigest
      #       builder.say_status :skipped, "#{f}" unless builder.nil?
      #       next
      #     end

      #     directory.files.new(
      #       :key => f.sub(prefix, ""),
      #       :body => body,
      #       :content_type => MIME::Types.of(f).first.content_type,
      #       :content_md5 => digest.base64digest,
      #       :expires => 24*3600*7,
      #       :acl => 'public-read'
      #     ).save

      #     builder.say_status :sync, "#{f}" unless builder.nil?

      #   end

      # end

    end
  end
end