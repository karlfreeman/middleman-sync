require 'middleman-core'

::Middleman::Extensions.register(:sync) do
  require 'middleman-sync/extension'
  ::Middleman::Sync::Extension
end

::Middleman::Extensions.register(:sync_source) do
  require 'middleman-sync/extension'
  ::Middleman::Sync::SourceExtension
end

::Middleman::Extensions.register(:sync_target) do
  require 'middleman-sync/extension'
  ::Middleman::Sync::TargetExtension
end