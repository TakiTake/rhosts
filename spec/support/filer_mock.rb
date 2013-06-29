module RHosts
  module Filer
    module Mock
      class << self
        def read(io)
          open('r')
            .and_yield(io)
        end

        def writable(bool)
          File
            .stub(:writable?)
            .with(RHosts.config.hosts_file_path)
            .and_return(bool)
        end

        def write(io)
          open('w')
            .and_yield(io)
        end

        def error(action)
          case action
          when 'read'
            open('r')
              .and_raise(Errno::ENOENT.new)
          when 'write'
            open('w')
              .and_raise(Errno::ENOENT.new)
          when 'writable'
            File
              .stub(:writable?)
              .and_raise(Errno::ENOENT.new)
          end
        end

        def reset
          File.unstub(:open)
          File.unstub(:writable?)
        end

        private
        def open(mode)
          File
            .stub(:open)
            .with(RHosts.config.hosts_file_path, mode)
        end
      end
    end
  end
end
