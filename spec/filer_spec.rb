require 'spec_helper'
require 'rhosts/filer'
require 'stringio'

describe 'Filer' do
  include_context 'capture_stderr'

  context 'hosts file is not exist' do
    before do
      FileMock.error('read')
    end

    it 'should display error message and exit' do
      err = capture_stderr do
        expect{ RHosts::Filer.load }.to raise_error(SystemExit)
      end

      expect(err.chomp).to eq("hosts file load error. #{RHosts.config.hosts_file_path}")
    end
  end

  context 'hosts file is exist' do
    before do
      @input  = input
      @output = output

      FileMock.read(@input)
      FileMock.writable(true)
      FileMock.write(@output)

      @actives, @inactives = RHosts::Filer.load
      RHosts::Filer.save(@actives, @inactives)
    end

    context 'but empty' do
      let(:input){ StringIO.new }
      let(:output){ StringIO.new }

      it 'should not have any mapping' do
        expect(@actives).to eq({})
        expect(@inactives).to eq({})
      end

      it 'should save nothing' do
        expect(@output.string).to be_empty
      end
    end

    context 'hosts file include active mapping' do
      let(:input){ StringIO.new("127.0.0.1 localhost") }
      let(:output){ StringIO.new }

      it 'should be loaded as active' do
        hosts = Set.new()
        hosts += ['localhost']
        expect(@actives).to eq({ '127.0.0.1' => hosts })
        expect(@inactives).to eq({})
      end

      it 'should be saved as active' do
        expect(@output.string).to eq(@input.string)
      end
    end

    context 'hosts file include inactive mapping' do
      let(:input){ StringIO.new("#127.0.0.1 localhost") }
      let(:output){ StringIO.new }

      it 'should be loaded as active' do
        hosts = Set.new()
        hosts += ['localhost']
        expect(@actives).to eq({})
        expect(@inactives).to eq({ '127.0.0.1' => hosts })
      end

      it 'should be saved as active' do
        expect(@output.string).to eq(@input.string)
      end
    end
  end
end
