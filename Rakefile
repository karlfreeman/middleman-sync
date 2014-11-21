require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec)

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
end

begin
  require 'rubocop/rake_task'
  desc 'Run rubocop'
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError
end

task default: :spec
task test: :spec
