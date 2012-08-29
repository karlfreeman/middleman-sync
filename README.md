# Middleman Sync

Synchronise your Middleman build to S3 and more

Middleman Sync is post build hook and cli for Middleman to allow you to use [Asset Sync](https://raw.github.com/rumblelabs/asset_sync) for your static build deployments.

## Installation

If you already have a Middleman project:

Add `middleman-sync` to your `Gemfile` then open up your `config.rb` and add:

### AWS

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.aws_access_key_id = 'super' # Your Amazon S3 access key
  sync.aws_secret_access_key = 'secret' # Your Amazon S3 access secret
  # sync.after_build = true # Run sync after build
  # sync.existing_remote_files = 'keep' # What to do with your existing remote files? (keep or delete)
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
  # sync.rackspace_auth_url = 'domain' # Your Rackspace auth URL
  # sync.after_build = true # Run sync after build
  # sync.existing_remote_files = 'keep' # What to do with your existing remote files? (keep or delete)
end
```

### Google Storage

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = 'bucket-name' # Your bucket name
  sync.fog_region = 'bucket-region-name' # The region your storage bucket is in
  sync.google_storage_access_key_id = 'super' # Your Google Storage access key
  sync.google_storage_secret_access_key = 'secret' # Your Google Storage access secret
  # sync.after_build = true # Run sync after build
  # sync.existing_remote_files = 'keep' # What to do with your existing remote files? (keep or delete)
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

## Todo

1. Replace AssetSync's logger to use Middleman's Thor builder.say_status

## Credits

Is essentially :

 - [https://github.com/rumblelabs/asset_sync](https://github.com/rumblelabs/asset_sync)

Cribbed :

- [https://github.com/tvaughan/middleman-deploy](https://github.com/tvaughan/middleman-deploy)
- [https://github.com/middleman/middleman-smusher](https://github.com/middleman/middleman-smusher)