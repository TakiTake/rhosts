require 'rubygems'
require 'bundler/setup'

lib_path = File.dirname(__FILE__)
$:.unshift(lib_path) unless $:.include?(lib_path)

require 'rhosts/configuration'

module RHosts
  def self.root
    @root ||= File.dirname(__FILE__)
  end

  def self.config
    @config ||= RHosts::Configuration.new
  end

  def self.configure
    yield config if block_given?
  end
end

# default setting
RHosts.configure do |c|
  c.hosts_file_path = '/etc/hosts'
  c.backup_dir      = '/etc'
  c.make_backup     = true
end
