require 'spec_helper'
require 'rhosts/filer'
require 'rhosts/console/app'

describe 'ConsoleMethods' do
  include RHosts::ConsoleMethods

  include_context 'alias_stub'
  include_context 'filer_stub'

  describe '#map' do
    context 'new host' do
      before do
        map 'localhost' => '127.0.0.1'
      end

      it 'mapped to actives' do
        hosts = Set.new()
        hosts += ['localhost']
        expect(actives).to eq({ '127.0.0.1' => hosts })
        expect(inactives).to eq({ '127.0.0.1' => Set.new })
      end
    end
  end

  describe '#unmap' do
    context 'new host' do
      before do
        unmap 'localhost' => '127.0.0.1'
      end

      it 'mapped to inactive' do
        hosts = Set.new()
        hosts += ['localhost']
        expect(actives).to eq({ '127.0.0.1' => Set.new })
        expect(inactives).to eq({ '127.0.0.1' => hosts })
      end
    end
  end
end
