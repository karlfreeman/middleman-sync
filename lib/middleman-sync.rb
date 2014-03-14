require 'middleman-core'

Middleman::Extensions.register(:sync) do
  require 'middleman-sync/extension'
  Middleman::Sync::Extension
end