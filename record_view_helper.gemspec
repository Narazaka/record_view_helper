$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "record_view_helper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "record_view_helper"
  s.version     = RecordViewHelper::VERSION
  s.authors     = ["Narazaka"]
  s.email       = ["info@narazaka.net"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RecordViewHelper."
  s.description = "TODO: Description of RecordViewHelper."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.0.beta1"
end
