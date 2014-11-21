if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby'
  begin
    require 'pry' unless ENV['CI']
  rescue LoadError
  end
end
