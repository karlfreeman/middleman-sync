require 'middleman-core'
require 'middleman-sync/commands'

::Middleman::Extensions.register(:sync, '>= 3.1.0') do
  require 'middleman-sync/extension'
  ::Middleman::Sync::Extension
end

::Middleman::Extensions.register(:sync_source, '>= 3.1.0') do
  require 'middleman-sync/extension'
  ::Middleman::Sync::SourceExtension
end

::Middleman::Extensions.register(:sync_target, '>= 3.1.0') do
  require 'middleman-sync/extension'
  ::Middleman::Sync::TargetExtension
end
