require 'readline'
require 'rhosts/filer'
require 'rhosts/console/app'
require 'rhosts/rulable'
require 'rhosts/alias'

module RHosts
  class Console
    include RHosts::ConsoleMethods
    include RHosts::Rulable
    include RHosts::Alias

    alias_host 'exp',       'www.example.com'
    alias_ip   'localhost', '127.0.0.1'

    class << self
      def start
        @console = new

        load_default_rules
        load_run_command

        unless File.writable?(RHosts.config.hosts_file_path) and RHosts.config.sudo?
          STDERR.puts "Hosts file is not writable. Please check permission"
          exit 1
        end

        @console.start
      end

      private
      def load_default_rules
        default_rules = File.read(RHosts.root + '/rhosts/console/default_rules.rb')
        @console.instance_eval(default_rules)
      end

      def load_run_command
        rhostsrc = File.join(File.expand_path("~"), ".rhostsrc")
        if File.exist?(rhostsrc)
          puts "load: #{rhostsrc}"
          @console.instance_eval(File.read(rhostsrc))
        end
      end
    end

    def initialize
      @actives, @inactives = RHosts::Filer.load
    end

    def start
      while command = Readline.readline('rhosts> ', true)
        # call matched rule with captures
        rules.each{ |rule, action| action.call($~.captures) if rule.match command.chomp }
      end
    end
  end
end
