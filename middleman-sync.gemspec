# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-sync/version"

Gem::Specification.new do |s|
  s.name        = "middleman-sync"
  s.version     = Middleman::Sync::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Karl Freeman"]
  s.email       = ["karlfreeman@gmail.com"]
  s.homepage    = "https://github.com/karlfreeman/middleman-sync"
  s.summary     = %q{Synchronise your Middleman build to S3 and more}
  s.description = %q{Middleman-Sync is a Middleman extension that wraps the excellent AssetSync to allow for both a CLI and after_build hook to your Middleman build's}

  s.rubyforge_project = "middleman-sync"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency("middleman-core", [">= 3.0.0"])
  s.add_runtime_dependency("asset_sync", ["~> 1.0.0"])
end
