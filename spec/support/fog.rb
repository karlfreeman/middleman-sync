require 'fog'
Fog::Mock.delay = 0

module Fog
  module SpecHelpers
    def self.extended(example_group)
      example_group.before(:each) do
        Fog.mock!
        Fog::Mock.reset
      end

      example_group.after(:each) do
        Fog.unmock!
      end
    end

    def self.included(example_group)
      example_group.extend self
    end
  end
end

RSpec.configure do |config|
  config.include Fog::SpecHelpers, fog: true
end
