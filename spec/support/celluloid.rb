require 'celluloid/test'
Celluloid.shutdown_timeout = 1
RSpec.configure do |config|
  config.around do |ex|
    Celluloid.actor_system = nil
    Thread.list.each do |thread|
      next if thread == Thread.current
      thread.kill
    end
    Celluloid.boot
    ex.run
    Celluloid.shutdown
  end
end
