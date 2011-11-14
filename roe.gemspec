# encoding: utf-8
require File.expand_path('../lib/roe/version', __FILE__)

Gem::Specification.new do |gem|
  gem.version     = Roe::VERSION
  gem.name        = 'roe'

  gem.author      = "Steve Agalloco"
  gem.email       = 'steve.agalloco@gmail.com'
  gem.homepage    = 'https://github.com/spagalloco/roe'
  gem.description = 'A simple Ruby oEmbed client'
  gem.summary     = 'A simple Ruby oEmbed client'

  gem.add_dependency "faraday_middleware", "~> 0.7"
  gem.add_dependency "multi_json", "~> 1.0"
  gem.add_dependency "multi_xml", "~> 0.4"
  gem.add_dependency "hashie", "~> 1.1"
  gem.add_dependency "rash", "~> 0.3"

  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rdiscount', '~> 1.6'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'simplecov', '~> 0.4'
  gem.add_development_dependency 'yard', '~> 0.7'
  gem.add_development_dependency 'webmock', '~> 1.7'
  gem.add_development_dependency 'vcr', '~> 1.11'

  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
end
