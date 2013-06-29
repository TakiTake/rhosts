require 'set'
require 'ipaddress'

module RHosts
  module ConsoleMethods
    def actives
      @actives ||= Hash.new{ |h, k| h[k] = Set.new }
    end

    def inactives
      @inactives ||= Hash.new{ |h, k| h[k] = Set.new }
    end

    def map(target)
      process(target) do |host, ip|
        inactivate(host)

        unless inactives[ip].empty?
          inactives[ip].delete_if{ |h| h == host }
        end

        inactives.delete(ip) if inactives[ip].empty?

        actives[ip] << host
        puts "map #{host} to #{ip}"
      end
    end

    def unmap(target)
      process(target) do |host, ip|
        unless actives[ip].empty?
          actives[ip].delete_if{ |h| h == host }
        end

        actives.delete(ip) if actives[ip].empty?

        inactives[ip] << host
        puts "unmap #{host} from #{ip}"
      end
    end

    # print mappings
    def display(title, mappings)
      puts "### #{title}"
      mappings.each do |ip, hosts|
        puts ip
        hosts.each{ |host| puts "  #{host}" }
        puts ''
      end
    end

    private
    def process(target, &block)
      raise ArgumentsError.new('mapping target must be Hash') unless target.instance_of? Hash

      # TODO
      # before_actions.each{ |action| action.call }

      target.each do |host, ip|
        host = alias_hosts[host] || host
        ip   = alias_ips[ip]     || ip

        ip_without_zone_index = ip.split('%')[0]
        unless IPAddress.valid?(ip_without_zone_index)
          warn "#{ip} is invalid IP Address!"
          next
        end

        block.call(host, ip)
      end

      RHosts::Filer.backup if RHosts.config.make_backup?
      RHosts::Filer.save(actives, inactives)

      # TODO
      # after_actions.each{ |action| action.call }
    end

    def inactivate(host)
      actives.each do |active_ip, active_hosts|
        if active_hosts.include?(host)
          active_hosts.delete(host)
          actives.delete(active_ip) if active_hosts.empty?

          inactives[active_ip] << host
        end
      end
    end
  end
end
