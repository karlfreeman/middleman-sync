require "awesome_print"
require "middleman-core"

require "middleman-sync/version"
require "middleman-sync/commands/sync"

::Middleman::Extensions.register(:sync, ">= 3.0.0") do
  require "middleman-sync/extension"
  ::Middleman::Sync
end