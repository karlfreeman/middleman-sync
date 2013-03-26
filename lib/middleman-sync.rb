require "middleman-core"
require "middleman-sync/version"

module Middleman

  module Sync
  end

end

::Middleman::Extensions.register(:sync) do
  require "middleman-sync/extension"
  ::Middleman::Sync
end