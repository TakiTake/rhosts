# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rhosts/version"

Gem::Specification.new do |s|
  s.name = "rhosts"
  s.version = RHosts::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.license = "MIT"
  s.authors = ["Takeshi Takizawa"]
  s.email = "TakiTake.create@gmail.com"
  s.homepage = "http://github.com/TakiTake/rhosts"
  s.summary = "rhosts-#{RHosts::Version::STRING}"
  s.description = "hosts file manager"

  s.rubyforge_project = "rhosts"
  s.add_dependency 'ipaddress', '~> 0.8.0'

  s.files = `git ls-files -- lib/*`.split("\n")
  s.files += ["License.txt"]
  s.test_files = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = [ "README.md" ]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_path = "lib"
end
