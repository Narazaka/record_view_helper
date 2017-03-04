class TestsController < ApplicationController
  def true
    render inline: "<%= format_view_value(true) %>"
  end

  def false
    render inline: "<%= format_view_value(false) %>"
  end
end
