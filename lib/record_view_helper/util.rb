require "active_support/core_ext/object/try"

module RecordViewHelper
  # format record value
  # @param [Object] record record
  # @param [Symbol] column target column name
  # @param [Proc|Symbol|Array<Symbol|Array<Symbol>>] format format
  # @param [Symbol|Hash<Symbol, Array<Symbol>>] link link options
  #
  # @example basic
  #   format_view_value(record, :name) == record.name
  #
  # @example with format
  #   format_view_value(record, :foo_id, [:foo_id, [:foo, :name]]) == "#{record.foo_id} #{record.foo.name}"
  #
  # @example with link
  #   format_view_value(record, :foo_id, nil, :foo_path) == link_to record.foo_id, foo_path(record.foo_id)
  #
  # @example with link with deep call
  #   format_view_value(record, :id, [:id, :name], foo_bar_path: [:foo_id, :id]) ==
  #     link_to "#{record.id} #{record.name}", foo_bar_path(record.foo_id, record.id)
  #
  def format_record_value(record, column, format = nil, link = nil)
    values =
      case format
      when Proc
        [defined?(capture) ? capture(record, &format) : format.call(record)]
      else
        deep_record_values(record, format || [column])
      end
    formatted_value = safe_join values.map {|value| [format_view_value(value), " "] }.flatten[0..-2]
    case link
    when String, Symbol
      link_record_value(record, formatted_value, link, [column])
    when Hash
      path_method, param_columns = link.first
      link_record_value(record, formatted_value, path_method, param_columns)
    when Proc
      link_uri = link.call(record)
      link_uri ? link_to(formatted_value, link_uri) : formatted_value
    else
      formatted_value
    end
  end

  # deep call as array
  #
  # @param [Object] record record
  # @param [Array<Symbol|Array<Symbol>>] columns call methods by columns
  #
  # @example
  #   deep_record_values(record, [:a, [:a, :b]]) == [record.a, record.a.b]
  #
  def deep_record_values(record, columns)
    columns.map {|column| deep_record_value(record, column) }
  end

  # deep call
  #
  # @param [Object] record record
  # @param [Symbol|Array<Symbol>] column call methods
  #
  # @example
  #   deep_record_value(record, [:a, :b]) == record.a.b
  #
  def deep_record_value(record, column)
    Array(column).reduce(record) {|receiver, method| receiver.try(:public_send, method) }
  end

  # format value
  # @param [Object] value value
  def format_view_value(value)
    case value
    when Date, Time, DateTime
      l(value)
    when true
      record_view_helper_config.true_view
    when false
      record_view_helper_config.false_view
    else
      value
    end
  end

  # make link_to
  # @param [Object] record record
  # @param [String] title link_to title
  # @param [Symbol] path_method path method name (like :root_path)
  # @param [Symbol|Array<Symbol|Array<Symbol>>] param_columns column call methods for  path method's args
  #
  # @example
  #   link_record_value(record, "title", :foo_bar_path, [:foo_id, :id])
  #   # makes...
  #   link_to "title", foo_bar_path(record.foo_id, record.id)
  #
  def link_record_value(record, title, path_method, param_columns)
    send_params = [path_method] + deep_record_values(record, Array(param_columns))
    link_to(title, send(*send_params))
  end

  private

    def record_view_helper_t(table_class, column)
      if record_view_helper_config.column_name
        record_view_helper_config.column_name.call(table_class, column)
      else
        table_name = table_class.name.tableize
        t(
          if record_view_helper_config.locale_name
            record_view_helper_config.locale_name.call(table_name, column)
          else
            "#{record_view_helper_config.locale_namespace}.#{table_name}.columns.#{column}"
          end,
        )
      end
    end
end
