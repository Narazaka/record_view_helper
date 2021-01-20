lib = File.expand_path("lib", __dir__) # rubocop:disable Gemspec/RequiredRubyVersion
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
  s.license     = "Zlib"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  if s.respond_to?(:metadata)
    s.metadata["yard.run"] = "yri"
  end

  s.add_runtime_dependency "actionview"
  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "tzinfo-data" if RUBY_PLATFORM =~ /mswin|mingw/
end
