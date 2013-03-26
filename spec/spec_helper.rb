$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$:.unshift(File.join(File.dirname(__FILE__), "..", "app"))

require "bundler"
Bundler.setup
begin; require "awesome_print"; rescue LoadError; end

require "rspec"

require "support/pry"
require "support/vcr"
require "support/timecop"
require "support/fakefs"
require "support/simplecov"

require "helpers/middleman_fixtures"

require "middleman-sync"

#
RSpec.configure do |config|
  include Middleman::Helpers::Fixtures
end