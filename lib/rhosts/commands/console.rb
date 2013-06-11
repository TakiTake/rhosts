require 'pp'
require 'readline'
require 'rhosts/console/app'

module RHosts
  class Console
    include RHosts::ConsoleMethods

    def self.start
      new.start
    end

    def start
      while cmd = Readline.readline('rhosts> ', true)
        case cmd.chomp
        when 'a', 'actives'
          p actives
        when 'i', 'inactives'
          p actives
        when 'history'
          p Readline::HISTORY.to_a
        when 'h', 'help'
          help
        when 'q', 'quit'
          exit
        end
      end
    end
  end
end
