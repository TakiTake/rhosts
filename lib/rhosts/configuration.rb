module RHosts
  class Configuration
    attr_accessor :hosts_file_path, :backup_dir, :make_backup, :sudo

    def make_backup?
      make_backup
    end

    def sudo?
      sudo
    end
  end
end
