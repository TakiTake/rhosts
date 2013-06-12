require 'pp'
require 'readline'
require 'rhosts/filer'
require 'rhosts/console/app'

module RHosts
  class Console
    include RHosts::ConsoleMethods

    def self.start
      new.start
    end

    def initialize
      @actives, @inactives = ::RHosts::Filer.load(hosts_path)
    end

    def hosts_path
      @hosts_path ||= '/etc/hosts'
    end

    def hosts_path=(path)
      @hosts_path = path
    end

    def start
      while cmd = Readline.readline('rhosts> ', true)
        case cmd.chomp
        when 'a', 'actives'
          p actives
        when 'i', 'inactives'
          p inactives
        when /^(m|map) +(.*?) +(.*?)$/
          map $2 => $3
        when /^(u|unmap) +(.*?) +(.*?)$/
          unmap $2 => $3
        when 'hist', 'history'
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
