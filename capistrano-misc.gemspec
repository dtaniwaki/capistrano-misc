$:.push File.expand_path("../lib", __FILE__)
require "capistrano-misc/version"

Gem::Specification.new do |s|
  s.name        = "capistrano-misc"
  s.version     = CapistranoMisc::Version
  s.authors     = ["Daisuke Taniwaki"]
  s.email       = ["daisuketaniwaki@gmail.com"]
  s.homepage    = "https://github.com/dtaniwaki/capistrano-misc"
  s.summary     = 'Useful tasks for Capistrano'
  s.description = 'Useful tasks for Capistrano'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license       = "MIT"

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'capistrano-spec'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rake'
end
