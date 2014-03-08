page '/index.html', layout: false

activate :sync do |config|
  config.verbose = true
  config.force = true
  config.run_on_build = true
end


activate :sync_target do |target|
  target.name = :middleman
  target.type = :aws
  target.target_dir = 'multi_sync'
  target.destination_dir = MultiSync::Extensions::Middleman.destination_dir
  target.credentials = {
    region: 'us-east-1',
    aws_access_key_id: 'xxx',
    aws_secret_access_key: 'xxx'
  }
end

activate :sync_source do |source|
  source.name = :assets
  source.type = :local
  source.source_dir = MultiSync::Extensions::Middleman.source_dir
end

