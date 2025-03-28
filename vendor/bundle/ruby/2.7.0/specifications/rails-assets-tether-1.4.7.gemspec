# -*- encoding: utf-8 -*-
# stub: rails-assets-tether 1.4.7 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-assets-tether".freeze
  s.version = "1.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["rails-assets.org".freeze]
  s.date = "2019-07-17"
  s.description = "A client-side library to make absolutely positioned elements attach to elements in the page efficiently.".freeze
  s.homepage = "http://github.hubspot.com/tether".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A client-side library to make absolutely positioned elements attach to elements in the page efficiently.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
