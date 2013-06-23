module RHosts
  class Configuration
    attr_accessor :hosts_file_path, :backup_dir, :make_backup

    def make_backup?
      make_backup
    end
  end
end
