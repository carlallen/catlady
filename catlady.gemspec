# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "catlady"
  s.license     = "Beer"
  s.authors     = ["Carl Allen"]
  s.email       = "carl@allenofmn.com"
  s.version     = "0.0"
  s.summary     = "Catlady"
  s.description = "Catlady things"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "debugger"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
