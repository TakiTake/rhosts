require 'pp'
require 'readline'
require 'rhosts/configuration'
require 'rhosts/filer'
require 'rhosts/console/app'

module RHosts
  class Console
    attr_accessor :config

    include RHosts::ConsoleMethods

    def self.start
      config = ::RHosts::Configuration.new
      console = new(config)
      console.start
    end

    def initialize(config)
      @config = config
      @actives, @inactives = ::RHosts::Filer.load(@config.hosts_file_path)
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
          puts Readline::HISTORY.to_a.join("\n")
        when 'h', 'help'
          help
        when 'q', 'quit'
          exit
        end
      end
    end
  end
end
