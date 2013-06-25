require 'spec_helper'
require 'rhosts/filer'
require 'rhosts/console/app'

describe 'ConsoleMethods' do
  include RHosts::ConsoleMethods
  include_context 'capture_stderr'

  before do
    RHosts.configure do |c|
      c.hosts_file_path = hosts_file_path
      c.backup_dir      = File.expand_path('../spec/tmp', RHosts.root)
      c.make_backup     = make_backup
      c.sudo            = false
    end

    @actives   = {}
    @inactives = {}
  end

  after do
    @actives.clear
    @inactives.clear
  end

  context 'hosts file is not exist' do
    let(:hosts_file_path){ File.expand_path('../spec/hosts/not_exist_path', RHosts.root) }
    let(:make_backup){ true }

    it 'should display error message and exit' do
      err = capture_stderr do
        expect{ RHosts::Filer.load }.to raise_error(SystemExit)
      end

      expect(err.chomp).to eq("hosts file load error. #{RHosts.config.hosts_file_path}")
    end
  end
end
