# -*- encoding: utf-8 -*-
# stub: date_time_precision 0.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "date_time_precision".freeze
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Butler".freeze]
  s.date = "2016-04-14"
  s.description = "Patches Date, Time, and DateTime ruby classes to keep track of precision".freeze
  s.email = ["dwbutler@ucla.edu".freeze]
  s.homepage = "http://github.com/Spokeo/date_time_precision".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Patches Date, Time, and DateTime ruby classes to keep track of precision".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["> 3"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_development_dependency(%q<json>.freeze, [">= 0"])
    s.add_development_dependency(%q<virtus>.freeze, ["= 0.5.4"])
    s.add_development_dependency(%q<coercible>.freeze, ["= 0.0.1"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["> 3"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<virtus>.freeze, ["= 0.5.4"])
    s.add_dependency(%q<coercible>.freeze, ["= 0.0.1"])
  end
end
