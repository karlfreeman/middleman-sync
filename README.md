# Middleman Sync

Synchronise your Middleman build to S3 and more

Middleman-Sync is a Middleman extension that wraps the excellant [Asset Sync](https://raw.github.com/rumblelabs/asset_sync) to allow for both a CLI and after_build hook to your Middleman build's

The after_build hook is `false` by default, to allow for a more 'opt-in' extension.

## Installation

If you already have a Middleman project:

Add `gem "middleman-sync", "~> 3.0.4"` to your `Gemfile` then open up your `config.rb` and add:

### AWS

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.aws_access_key_id = 'super' # Your Amazon S3 access key
  sync.aws_secret_access_key = 'secret' # Your Amazon S3 access secret
  sync.existing_remote_files = 'keep' # What to do with your existing remote files? ( keep or delete )
  # sync.after_build = true # Enable sync to run after Middleman build ( defaults to false )
end
```

### Rackspace

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'Rackspace' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.rackspace_username = 'karlfreeman' # Your Rackspace username
  sync.rackspace_api_key = 'secret' # Your Rackspace API Key
  sync.existing_remote_files = 'keep' # What to do with your existing remote files? ( keep or delete )
  # sync.rackspace_auth_url = 'domain' # Your Rackspace auth URL
  # sync.after_build = true # Enable sync to run after Middleman build ( defaults to false )
end
```

### Google Storage

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'Google' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.google_storage_access_key_id = 'super' # Your Google Storage access key
  sync.google_storage_secret_access_key = 'secret' # Your Google Storage access secret
  sync.existing_remote_files = 'keep' # What to do with your existing remote files? ( keep or delete )
  # sync.after_build = true # Enable sync to run after Middleman build ( defaults to false )
end
```

## Usage

Once you've bundled you should be able to run:

``` ruby 
# Sync your current build directory
middleman sync
```

``` ruby 
# Turn on after_build in your sync config to run middleman sync after each build
middleman build
```

## Sync to multiple targets

Middleman and Middleman-Sync are both environment agnostic. To be able to sync different versions of Middleman to different locations ( eg staging, production ) You might try running `middleman build` with environment varibles swapping out the sync credentials that need changing pre requirements.

Modifying the activate area to use an `ENV['FOG_DIRECTORY']` would allow you to run `FOG_DIRECTORY=example-staging middleman build` which then would sync to a different bucket on S3.

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = ENV['FOG_DIRECTORY'] # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.aws_access_key_id = 'super' # Your Amazon S3 access key
  sync.aws_secret_access_key = 'secret' # Your Amazon S3 access secret
  sync.existing_remote_files = 'keep' # What to do with your existing remote files? (keep or delete)
  sync.after_build = true # Enable sync to run after Middleman build ( defaults to false )
end
```

## Credits

Using:

 - [https://github.com/rumblelabs/asset_sync](https://github.com/rumblelabs/asset_sync)

Cribbed:

- [https://github.com/tvaughan/middleman-deploy](https://github.com/tvaughan/middleman-deploy)
- [https://github.com/middleman/middleman-smusher](https://github.com/middleman/middleman-smusher)
