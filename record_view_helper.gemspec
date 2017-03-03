$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "record_view_helper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "record_view_helper"
  s.version     = RecordViewHelper::VERSION
  s.authors     = ["Narazaka"]
  s.email       = ["info@narazaka.net"]
  s.homepage    = "https://github.com/Narazaka/record_view_helper"
  s.summary     = "table builder and description list (dl) helper for Rails / ActiveModels"
  s.description = "This module provides table_for(model) and dl_for(model) helpers."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails", "~> 5.1.0.beta1"
  s.add_development_dependency "rspec-rails", "~> 3"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "yard"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "onkcop"
end
