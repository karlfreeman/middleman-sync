# Middleman Sync ( WIP ) [![Gem Version](https://badge.fury.io/rb/middleman-sync.png)][gem] [![Build Status](https://travis-ci.org/karlfreeman/middleman-sync.png?branch=feature/3-1-rewrite)][travis] [![Dependency Status](https://gemnasium.com/karlfreeman/middleman-sync.png?travis)][gemnasium] [![Coverage Status](https://coveralls.io/repos/karlfreeman/middleman-sync/badge.png?branch=feature/3-1-rewrite)][coveralls] [![Code Climate](https://codeclimate.com/github/karlfreeman/middleman-sync.png)][codeclimate]

Synchronise your Middleman build to S3 and more

[gem]: https://rubygems.org/gems/middleman-sync
[travis]: http://travis-ci.org/karlfreeman/middleman-sync
[gemnasium]: https://gemnasium.com/karlfreeman/middleman-sync
[coveralls]: https://coveralls.io/r/karlfreeman/middleman-sync
[codeclimate]: https://codeclimate.com/github/karlfreeman/middleman-sync

## Usage Examples

Middleman-Sync is a [Middleman][middleman] extension...

[middleman]: http://middlemanapp.com/

```ruby

# preview syntax

# S3
activate :sync_source do |sync|
  sync.provider = :aws
  sync.region = 'us-east-1'
  sync.access_key_id = 'super'
  sync.secret_access_key = 'secret'
end

# Google Storage
activate :sync_source do |sync|
  sync.provider = :google
  sync.region = 'us-east-1'
  sync.access_key_id = 'super'
  sync.secret_access_key = 'secret'
end

# Rackspace
activate :sync_source do |sync|
  sync.provider = :rackspace
  sync.region = 'bucket-region-name'
  sync.rackspace_username = 'super'
  sync.rackspace_api_key = 'secret'
  # sync.rackspace_auth_url = 'lon.auth.api.rackspacecloud.com'
end

#
activate :sync_target do |target|
  target.sync_source = :aws
  target.directory = 'example-bucket/images'
  target.glob = '**/*.jpg'
  target.cache_control = 'max-age=315576000'
  target.storage_class = :rrs
end

#
activate :sync_target do |target|
  target.sync_source = :aws
  target.directory = 'example-bucket'
  target.glob = '**/*.html'
  target.cache_control = 'max-age=100'
  target.storage_class = :standard
end

```

## Supported Storage Services
Behind the scenes we're using [Fog::Storage][fog storage] which allows us to support the most popular storage providers

[fog storage]: http://fog.io/storage/

* [Amazon S3](http://aws.amazon.com/s3/)
* [Rackspace CloudFiles](http://www.rackspace.com/cloud/files/)
* [Google Cloud Storage](https://developers.google.com/storage/)

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
