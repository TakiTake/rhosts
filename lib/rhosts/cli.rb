Signal.trap("INT") { puts; exit(1) }

# TODO: Runnable not only console but also exec from file, string and so on.
require 'rhosts/commands/console'
