# -*- encoding: utf-8 -*-
require File.expand_path('../lib/date_time_precision/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Butler"]
  gem.email         = ["dwbutler@ucla.edu"]
  gem.description   = %q{Patches Date, Time, and DateTime ruby classes to keep track of precision}
  gem.summary       = %q{Patches Date, Time, and DateTime ruby classes to keep track of precision}
  gem.homepage      = "http://github.com/Spokeo/date_time_precision"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "date_time_precision"
  gem.require_paths = ["lib"]
  gem.version       = DateTimePrecision::VERSION
  gem.license       = 'MIT'
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '> 3'
  gem.add_development_dependency 'appraisal'
  
  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'json'
  
  gem.add_development_dependency 'virtus', '0.5.4'
  gem.add_development_dependency 'coercible', '0.0.1'
end
