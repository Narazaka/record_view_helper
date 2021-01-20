require "action_view"

class MyView < ActionView::Base
  include RecordViewHelper

  def compiled_method_container
    self.class
  end

  def self.compiled_method_container
    self.class
  end

  def foo_path(id)
    "foo/#{id}"
  end

  def foo_bar_path(foo_id, id)
    "foo/#{foo_id}/bar/#{id}"
  end
end

class Foo
  attr_accessor :id, :name

  def initialize(id = nil, name = nil)
    @id = id
    @name = name
  end

  def attributes
    {
      "id" => id,
      "name" => name,
    }
  end
end

class Bar
  attr_accessor :id, :name, :foo

  def initialize(id = nil, name = nil, foo = nil)
    @id = id
    @name = name
    @foo = foo
  end

  def foo_id
    foo.id
  end

  def attributes
    {
      "id" => id,
      "name" => name,
      "foo_id" => foo_id,
    }
  end
end
