module RHosts
  module Alias
    def self.included(base)
      base.extend ClassMethods
    end

    def alias_ips
      self.class.alias_ips
    end

    def alias_ip(new_name, old_name)
      self.class.alias_ips[new_name] = old_name
    end

    def alias_hosts
      self.class.alias_hosts
    end

    def alias_host(new_name, old_name)
      self.class.alias_hosts[new_name] = old_name
    end

    module ClassMethods
      def alias_ips
        @alias_ips ||= {}
      end

      def alias_ip(new_name, old_name)
        alias_ips[new_name] = old_name
      end

      def alias_hosts
        @alias_hosts ||= {}
      end

      def alias_host(new_name, old_name)
        alias_hosts[new_name] = old_name
      end
    end
  end
end
