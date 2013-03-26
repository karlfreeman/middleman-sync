require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr"
  c.hook_into :webmock
  c.ignore_hosts "127.0.0.1", "0.0.0.0", "localhost"
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
end