source 'https://rubygems.org'

gem 'rake', '>= 1.2'
gem 'yard'

# platforms :ruby_18 do
# end
# platforms :ruby, :mswin, :mingw do
# end
# platforms :jruby do
# end

gem 'celluloid', :github => 'celluloid/celluloid'
gem 'multi_mime', :github => 'karlfreeman/multi_mime'
gem 'multi_sync', :github => 'karlfreeman/multi_sync'

group :development do
  gem 'kramdown', '>= 0.14'
  gem 'pry'
  gem 'pry-debugger', :platforms => :mri_19
end

group :test do
  gem 'rspec'
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
  gem 'fakefs', :require => 'fakefs/safe'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
end

gemspec
