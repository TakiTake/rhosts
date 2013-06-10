require 'spec_helper'
require 'rhosts/console/app'

describe 'ConsoleMethods' do
  include RHosts::ConsoleMethods

  describe '#map' do
    before do
      map 'example.com' => '127.0.0.1'
    end

    after do
      @actives.clear
      @inactives.clear
    end

    it 'map example.com to 127.0.0.1' do
      expect(actives).to eq('127.0.0.1' => ['example.com'])
      expect(inactives).to eq({ })
    end
  end
end
