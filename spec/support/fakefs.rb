require 'fakefs/safe'
require 'fakefs/spec_helpers'
require 'pathname'
require 'fileutils'
RSpec.configure do |config|
  config.include FakeFS::SpecHelpers, fakefs: true
end
