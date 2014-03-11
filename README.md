# Middleman Sync (WIP)

Synchronise your Middleman build to S3 and more

Middleman-Sync is a [Middleman](http://middlemanapp.com) extension...

## Installation

```ruby
gem 'middleman-sync', '~> 4.0'
```

```ruby
configure :build do
  activate :sync do |config|
    # config.verbose = false  # turn on verbose logging (defaults to false)
    # config.force = false  # force syncing of outdated_files (defaults to false)
    # config.run_on_build = true # when within a framework which `builds` assets, whether to sync afterwards (defaults to true)
    # config.sync_outdated_files = true # when an outdated file is found whether to replace it (defaults to true)
    # config.delete_abandoned_files = true # when an abondoned file is found whether to remove it (defaults to true)
    # config.upload_missing_files = true # when a missing file is found whether to upload it (defaults to true)
    # config.target_pool_size = 8 # how many threads you would like to open for each target (defaults to the amount of CPU core's your machine has)
    # config.max_sync_attempts = 3 # how many times a file should be retried if there was an error during sync (defaults to 3)
  end
end
```

## Features / Usage Examples

### Source

```ruby
configure :build do
  activate :sync_source do |source|
    source.name = :middleman
    source.type = :local
    source.source_dir = MultiSync::Extensions::Middleman.source_dir
  end
end
```

### Target

```ruby
configure :build do
  activate :sync_target do |target|
    target.name = :assets
    target.type = :aws
    target.target_dir = 'multi-sync-middleman'
    target.credentials = {
      region: 'us-east-1',
      aws_access_key_id: 'xxx',
      aws_secret_access_key: 'xxx'
    }
  end
end
```

## Badges

[![Gem Version](http://img.shields.io/gem/v/middleman-sync.svg)][gem]
[![Build Status](http://img.shields.io/travis/karlfreeman/middleman-sync.svg)][travis]
[![Code Quality](http://img.shields.io/codeclimate/github/karlfreeman/middleman-sync.svg)][codeclimate]
[![Gittip](http://img.shields.io/gittip/karlfreeman.svg)][gittip]

## Supported Storage Services

Behind the scenes we're using [Fog::Storage](http://fog.io/storage) which allows us to support the most popular storage providers

- [Amazon S3](http://aws.amazon.com/s3)
- [Rackspace CloudFiles](http://www.rackspace.com/cloud/files) (WIP)
- [Google Cloud Storage](https://developers.google.com/storage) (WIP)

## Supported Ruby Versions

This library aims to support and is [tested against][travis] the following Ruby
implementations:

- Ruby 2.1.0
- Ruby 2.0.0
- Ruby 1.9.3
- [JRuby][jruby]
- [Rubinius][rubinius]

# Credits

[gem]: https://rubygems.org/gems/middleman-sync
[travis]: http://travis-ci.org/karlfreeman/middleman-sync
[codeclimate]: https://codeclimate.com/github/karlfreeman/middleman-sync
[gittip]: https://www.gittip.com/karlfreeman
[jruby]: http://www.jruby.org
[rubinius]: http://rubini.us
