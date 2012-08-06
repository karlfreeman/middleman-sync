# Middleman Sync

Synchronises Assets between Middleman and S3.

Middleman Sync is post build hook and cli for Middleman to allow you to use [Asset Sync](https://raw.github.com/rumblelabs/asset_sync) for your static build deployments

If you already have a Middleman project:
Add `middleman-sync` to your `Gemfile`, open up your `config.rb` and add:

``` ruby
# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS'
  sync.fog_directory = ''
  sync.aws_access_key_id = ''
  sync.aws_secret_access_key = ''
end
```