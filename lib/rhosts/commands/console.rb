require 'pp'
require 'rhosts/console/app'
require 'irb'
require 'irb/completion'

module RHosts
  class Console
    def self.start
      new.start
    end

    def start
      IRB::ExtendCommandBundle.send :include, RHosts::ConsoleMethods
      IRB.start
    end
  end
end
