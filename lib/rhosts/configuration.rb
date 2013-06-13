module RHosts
  class Configuration
    attr_writer :hosts_file_path

    def initialize
      @@options ||= {}
    end

    def hosts_file_path
      @hosts_file_path ||= '/etc/hosts'
    end
  end
end
