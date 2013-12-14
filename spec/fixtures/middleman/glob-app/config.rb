page '/index.html', :layout => false

activate :sync do |config|
  config.logging = true
  config.verbose = true
  config.force = true
  config.run_on_build = true
end

activate :sync_source do |source|
  source.name = :public
  source.type = :local
  source.source_dir = File.expand_path(File.join(ENV['MM_ROOT'], 'build'))
  source.targets = [ :www ]
end

activate :sync_target do |target|
  target.name = :www
  target.type = :aws
  target.target_dir = 'multi_sync'
  # target.destination_dir = 'an_optional_directory_inside_your_aws_bucket'
  target.credentials = {
    :region => 'us-east-1',
    :aws_access_key_id => 'AKIAJXMAC4YJEHPBYSHQ',
    :aws_secret_access_key => 'e8HuMafMCN4R2s+iMolDnbSnf3J/jqF0ejPLEiLT'
  }
end
