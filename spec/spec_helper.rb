require "simplecov"
SimpleCov.start do
  add_filter "spec"
  add_filter ".bundle"
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "record_view_helper"
