require 'middleman-core'
require 'middleman-sync/version'

::Middleman::Extensions.register(:sync) do
  require 'middleman-sync/extension'
  ::Middleman::Sync
end