# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'middleman-sync/version'

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'middleman-core', '>= 3.0.0'
  gem.add_runtime_dependency 'asset_sync', '~> 1.0.0'
  gem.add_development_dependency 'bundler', '>= 1.0'
  gem.name          = 'middleman-sync'
  gem.version       = Middleman::Sync::VERSION
  gem.authors       = ['Karl Freeman']
  gem.email         = ['karlfreeman@gmail.com']
  gem.license       = 'MIT'
  gem.description   = %q{Middleman-Sync is a Middleman extension that wraps the excellent AssetSync to allow for both a CLI and after_build hook to your Middleman build's}
  gem.summary       = %q{Synchronise your Middleman build to S3 and more}
  gem.homepage      = 'https://github.com/karlfreeman/rubykiq'
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.required_ruby_version = '>= 1.9.2'
end