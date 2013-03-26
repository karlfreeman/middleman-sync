if defined?(RUBY_ENGINE) && RUBY_ENGINE == "ruby"

  require "simplecov"

  if ENV["CI"]
    require "coveralls"
    Coveralls.wear!
    SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  end

  SimpleCov.start do
    add_filter "vendor"
  end

end