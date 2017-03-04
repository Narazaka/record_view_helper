module RecordViewHelper
  # RecordViewHelper config
  class Config
    def initialize
      @true_view = true
      @false_view = false
      @locale_namespace = "record_view_helper"
    end

    # text/html(raw) which is showed when true === value
    # @return [String] (defalut = true)
    attr_accessor :true_view

    # text/html(raw) which is showed when false === value
    # @return [String] (defalut = false)
    attr_accessor :false_view

    # Proc which returns name for t(name)
    #
    # @example in Rails
    #   Rails.application.config.record_view_helper.locale_name =
    #     ->(table_name, column) { "columns.#{table_name}.#{column}" }
    #
    # @example basic
    #   class MyView < ActionView::Base
    #     include RecordViewHelper
    #   end
    #
    #   MyView.record_view_helper_config.locale_name =
    #     ->(table_name, column) { "columns.#{table_name}.#{column}" }
    #
    # @return [Proc]
    attr_accessor :locale_name

    # namespace for `t()`
    #
    # @example
    #   # locale_namespace is used like below
    #   t("#{locale_namespace}.#{table_name}.columns.#{column}")
    #
    #   # if you want to use another hierarchy, you should use #locale_name.
    #
    # @return [String] (default = "record_view_helper")
    attr_accessor :locale_namespace
  end
end
