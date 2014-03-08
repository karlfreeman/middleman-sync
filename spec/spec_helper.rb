$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler'
Bundler.setup

%w(support helpers shared).each do |dir|
  Dir.glob(File.expand_path("../#{dir}/**/*.rb", __FILE__), &method(:require))
end

require 'middleman-sync'

RSpec.configure do |config|
  include Middleman::Helpers::Fixtures
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
