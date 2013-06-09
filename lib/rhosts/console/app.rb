module RHosts
  module ConsoleMethods
    def map(target)
      @actives ||= {}

      aaa(target) do |host, ip|
        @actives[ip] ||= []
        @actives[ip] << host
      end
    end

    def unmap(target)
      @inactives ||= {}

      aaa(target) do |host, ip|
        @inactives[ip] ||= []
        @inactives[ip] << host
      end
    end

    private
    def aaa(target, &block)
      raise ArgumentsError.new('mapping target must be Hash') unless target.instance_of? Hash

      # TODO
      # before_actions.each{ |action| action.call }

      target.each do |host, ip|
        block.call(host, ip)
        p @actives
        p @inactives
      end

      # TODO
      # after_actions.each{ |action| action.call }
    end
  end
end
