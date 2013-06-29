shared_context 'filer_stub' do
  before do
    RHosts::Filer.stub(:load).and_return(true)
    RHosts::Filer.stub(:backup).and_return(true)
    RHosts::Filer.stub(:save).and_return(true)
  end
end
