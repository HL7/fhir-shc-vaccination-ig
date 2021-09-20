# -*- encoding: utf-8 -*-
# stub: fhir_models 4.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fhir_models".freeze
  s.version = "4.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jason Walonoski".freeze, "Andre Quina".freeze, "Michael O'Keefe".freeze, "Robert Scanlon".freeze, "Reece Adamson".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-06-24"
  s.description = "A Gem for handling FHIR models in ruby".freeze
  s.email = ["jwalonoski@mitre.org".freeze]
  s.homepage = "https://github.com/fhir-crucible/fhir_models".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "A Gem for handling FHIR models in ruby".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.11.4"])
    s.add_runtime_dependency(%q<date_time_precision>.freeze, [">= 0.8"])
    s.add_runtime_dependency(%q<bcp47>.freeze, [">= 0.3"])
    s.add_runtime_dependency(%q<mime-types>.freeze, [">= 3.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry-coolline>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.17.0"])
    s.add_development_dependency(%q<nokogiri-diff>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 0.80"])
    s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-test>.freeze, [">= 0"])
  else
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.11.4"])
    s.add_dependency(%q<date_time_precision>.freeze, [">= 0.8"])
    s.add_dependency(%q<bcp47>.freeze, [">= 0.3"])
    s.add_dependency(%q<mime-types>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pry-coolline>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.17.0"])
    s.add_dependency(%q<nokogiri-diff>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.80"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<guard-test>.freeze, [">= 0"])
  end
end
