require "active_support/lazy_load_hooks"

module RecordViewHelper
  # loader for rails
  class Railtie < ::Rails::Railtie
    config.record_view_helper = RecordViewHelper::Config.new

    initializer "record_view_helper.cofigure" do
      ActiveSupport.on_load(:action_view) do
        ActionView::Base.include(RecordViewHelper)
      end
    end
  end
end
