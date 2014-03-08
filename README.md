# Middleman Sync (WIP)

Synchronise your Middleman build to S3 and more

Middleman-Sync is a [Middleman][middleman] extension...

## Installation

```ruby
gem 'middleman-sync', '~> 4.0'
```

## Features / Usage Examples

```ruby
# S3
activate :sync_target do |target|
  target.provider = :aws
  target.region = 'us-east-1'
  target.access_key_id = 'super'
  target.secret_access_key = 'secret'
end

# Google Storage
activate :sync_target do |target|
  target.provider = :google
  target.region = 'us-east-1'
  target.access_key_id = 'super'
  target.secret_access_key = 'secret'
end

# Rackspace
activate :sync_target do |target|
  target.provider = :rackspace
  target.region = 'bucket-region-name'
  target.rackspace_username = 'super'
  target.rackspace_api_key = 'secret'
  # target.rackspace_auth_url = 'lon.auth.api.rackspacecloud.com'
end

#
activate :sync_source do |target|
  source.sync_target = :aws
  source.directory = 'example-bucket/images'
  source.glob = '**/*.jpg'
  source.cache_control = 'max-age=315576000'
  source.storage_class = :rrs
end

#
activate :sync_source do |source|
  source.sync_target = :aws
  source.directory = 'example-bucket'
  source.glob = '**/*.html'
  source.cache_control = 'max-age=100'
  source.storage_class = :standard
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
