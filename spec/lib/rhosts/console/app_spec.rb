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
        expect(actives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
        expect(inactives).to eq({ })
      end
    end

    context 'duplicated host' do
      before do
        actives['127.0.0.1'] << 'localhost'
        map 'localhost' => '127.0.0.1'
      end

      it 'mapped only one to actives' do
        expect(actives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
        expect(inactives).to eq({ })
      end
    end

    context 'unmapped host' do
      before do
        inactives['127.0.0.1'] << 'localhost'
        map 'localhost' => '127.0.0.1'
      end

      it 'mapped to actives' do
        expect(actives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
        expect(inactives).to eq({ })
      end
    end

    context 'mapped other host' do
      before do
        actives['127.0.0.2'] << 'localhost'
        map 'localhost' => '127.0.0.1'
      end

      it 'mapped to actives' do
        expect(actives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
        expect(inactives).to eq({ '127.0.0.2' => Set.new(['localhost']) })
      end
    end
  end

  describe '#unmap' do
    context 'new host' do
      before do
        unmap 'localhost' => '127.0.0.1'
      end

      it 'mapped to inactive' do
        expect(actives).to eq({ })
        expect(inactives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
      end
    end

    context 'duplicated host' do
      before do
        inactives['127.0.0.1'] << 'localhost'
        unmap 'localhost' => '127.0.0.1'
      end

      it 'mapped only one to actives' do
        expect(actives).to eq({ })
        expect(inactives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
      end
    end

    context 'mapped host' do
      before do
        actives['127.0.0.1'] << 'localhost'
        unmap 'localhost' => '127.0.0.1'
      end

      it 'mapped to actives' do
        expect(actives).to eq({ })
        expect(inactives).to eq({ '127.0.0.1' => Set.new(['localhost']) })
      end
    end

    context 'unmapped other host' do
      before do
        inactives['127.0.0.2'] << 'localhost'
        unmap 'localhost' => '127.0.0.1'
      end

      it 'mapped to actives' do
        expect(actives).to eq({ })
        expect(inactives).to eq({ '127.0.0.1' => Set.new(['localhost']), '127.0.0.2' => Set.new(['localhost']) })
      end
    end
  end
end
