require "middleman-core"
require "middleman-sync/commands"

::Middleman::Extensions.register(:sync, ">= 3.0.0") do
  require "middleman-sync/extension"
  ::Middleman::Sync
end