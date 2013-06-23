require 'ipaddress'

module RHosts
  module Filer
    class << self
      def load
        actives = {}
        inactives = {}

        File.open(RHosts.config.hosts_file_path, 'r') do |file|
          file.each do |line|
            storage = Mapping.active?(line) ? actives : inactives

            Mapping.parse(line) do |ip, hosts|
              next if ip.nil? or hosts.empty?

              # IPAddress gem can't parse IP with zone index
              #
              # for example
              #   fe80::1%lo0
              ip_without_zone_index = ip.split('%')[0]
              next unless IPAddress.valid?(ip_without_zone_index)

              storage[ip] ||= []
              storage[ip] += hosts
            end
          end
        end

        [actives, inactives]
      end

      def backup
        bk_file_path = backup_file_path
        hosts_file_path = RHosts.config.hosts_file_path

        if File.writable?(RHosts.config.backup_dir)
          FileUtils.cp(hosts_file_path, bk_file_path)
          puts "backup: #{bk_file_path}"
        else
          STDERR.puts "backup file is not writable. #{bk_file_path}"
          STDERR.puts 'So we will backup to tmp dir'
          tmp = tmp_file_path
          FileUtils.cp(hosts_file_path, tmp)
          STDERR.puts "backup: #{tmp}"
        end
      end

      def save(actives, inactives)
        # TODO: reload hosts file if chnaged after load
        hosts_file_path = RHosts.config.hosts_file_path
        unless File.writable?(hosts_file_path)
          STDERR.puts "Hosts file is not writable. Please check permission"
          exit 1
        end

        File.open(RHosts.config.hosts_file_path, 'w') do |file|
          actives.each{ |ip, hosts| file.write("#{ip} #{hosts.join(' ')}\n") }
          inactives.each{ |ip, hosts| file.write("##{ip} #{hosts.join(' ')}\n") }
        end
        puts "save: #{hosts_file_path}"
      end

      private
      def backup_file_path
        hosts_file_path = RHosts.config.hosts_file_path
        basename = File.basename(hosts_file_path)
        File.join(RHosts.config.backup_dir, "#{basename}.#{Time.now.to_i}")
      end

      def tmp_file_path
        hosts_file_path = RHosts.config.hosts_file_path
        basename = File.basename(hosts_file_path)
        File.join('/tmp', "#{basename}.#{Time.now.to_i}")
      end
    end

    class Mapping
      class << self
        def active?(line)
          line !~ /^#/
        end

        def parse(line, &block)
          ip, *hosts = line.chomp.sub(/^#+\s*/, '').split(/\s+/)
          block.call(ip, hosts)
        end
      end
    end
  end
end
