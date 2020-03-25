lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "record_view_helper/version"

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

  if s.respond_to?(:metadata)
    s.metadata["yard.run"] = "yri"
  end

  s.add_runtime_dependency "actionview"
  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "tzinfo-data" if RUBY_PLATFORM =~ /mswin|mingw/
  s.add_development_dependency "bundler"
  s.add_development_dependency "onkcop"
  s.add_development_dependency "rails", ">= 4"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails", "~> 4"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "yard"
end
