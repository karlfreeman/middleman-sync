# Middleman Sync

Synchronise your Middleman build to S3 and more

Middleman-Sync is a [Middleman](https://github.com/middleman/middleman) extension that wraps the excellant [Asset Sync](https://raw.github.com/rumblelabs/asset_sync) to allow for both a CLI and after_build hook to your Middleman build's

## Installation

If you already have a Middleman project:

Add `gem "middleman-sync", "~> 3.0.12"` to your `Gemfile` then open up your `config.rb` and add:

### AWS

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in (eg us-east-1, us-west-1, eu-west-1, ap-southeast-1 )
  sync.aws_access_key_id = 'super' # Your Amazon S3 access key
  sync.aws_secret_access_key = 'secret' # Your Amazon S3 access secret
  sync.existing_remote_files = 'keep' # What to do with your existing remote files? ( keep or delete )
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end
```

### Rackspace

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'Rackspace' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.rackspace_username = 'super' # Your Rackspace username
  sync.rackspace_api_key = 'secret' # Your Rackspace API Key
  sync.existing_remote_files = 'keep' # What to do with your existing remote files? ( keep or delete )
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.rackspace_auth_url = 'domain' # Your Rackspace auth URL
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
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
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end
```

## Usage

Once you've bundled you should be able to run:

``` ruby 
# Turn off after_build in your sync config to disable middleman sync running after each build
middleman build
```

``` ruby 
# Manually sync your current build directory
middleman sync
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
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end
```

## Credits

- [Asset Sync](https://github.com/rumblelabs/asset_sync)

Cribbed:

- [Middleman Deploy](https://github.com/tvaughan/middleman-deploy)
- [Middleman Smusher](https://github.com/middleman/middleman-smusher)
