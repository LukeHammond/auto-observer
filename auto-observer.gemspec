# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "auto-observer/version"

Gem::Specification.new do |s|
  s.name        = "auto-observer"
  s.version     = AutoObserver::VERSION
  s.authors     = ["LukeHammond"]
  s.email       = ["luke.e.j.hammond@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{wrap callbacks and observability around custom instance methods}
  s.description = %q{conveniently define instance methods to be wrapped by callbacks, whilst enabling observers for these same methods}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_development_dependency "rspec-rails"
  
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
