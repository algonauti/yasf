# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yasf/version"

Gem::Specification.new do |s|
  s.name        = "yasf"
  s.version     = Yasf::VERSION
  s.authors     = ["Algonauti"]
  s.email       = ["devel@algonauti.com"]
  s.homepage    = "https://github.com/algonauti/yasf"
  s.summary     = %q{Uses DSL to write easy, maintainable HTML scraping rules.}
  s.description = %q{HTML scraping to write maintainable rules to extract data from HTML content.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('nokogiri', '1.5.5')
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fakeweb'
    
end
