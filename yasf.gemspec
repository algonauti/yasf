# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yasf/version'

Gem::Specification.new do |spec|
  spec.name          = "yasf"
  spec.version       = Yasf::VERSION
  spec.authors       = ["Salvatore Ferrucci"]
  spec.email         = ["salvatore@algonauti.com"]
  spec.summary       = %q{scrape static html sites}
  spec.description   = %q{scrape static html sites}
  spec.homepage      = "https://github.com/algonauti/yasf"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Runtime
  spec.add_runtime_dependency "rest-client", '~> 1.6.7'
  spec.add_runtime_dependency "nokogiri", '~> 1.6.1'
  spec.add_runtime_dependency "activesupport", '~> 4.0.2'

  # Developmenet
  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"

  # Test
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "fakeweb"
end
