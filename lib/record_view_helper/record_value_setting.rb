require "active_support/core_ext/enumerable"
require "active_support/core_ext/object/blank"

module RecordViewHelper
  # columns with formats, links, etc.
  class RecordValueSetting
    # format settings
    attr_reader :formats
    # link settings
    attr_reader :links
    # attr settings
    attr_reader :attrs
    # header attr settings
    attr_reader :header_attrs

    # build from hash
    #
    # **caution**: this method deletes given hash options' key
    # @param [Array<Symbol>] columns default columns
    # @param [Symbol] table_name default table name
    # @param [Hash] options option hash
    # @return [RecordValueSetting]
    def self.build_from_hash!(columns, table_name, options = {})
      new(
        columns,
        options.delete(:table_name) || table_name,
        only: options.delete(:only),
        except: options.delete(:except),
        formats: options.delete(:formats),
        links: options.delete(:links),
        attrs: options.delete(:attrs),
        header_attrs: options.delete(:header_attrs),
      )
    end

    # @param [Array<Symbol>] columns default columns
    # @param [Symbol] table_name default table name
    # @param [Array<Symbol>] only only columns
    # @param [Array<Symbol>] except except columns
    # @param [Hash<Symbol, Symbol|Array<Symbol|Array<Symbol>>>] formats formats
    # @param [Hash<Symbol, Symbol|Hash<Symbol, Symbol|Array<Symbol>>>] links links settings
    # @param [Hash<Symbol, Hash<Symbol, String>>] attrs column value dom tag attrs
    # @param [Hash<Symbol, Hash<Symbol, String>>] header_attrs column header dom tag attrs
    def initialize( # rubocop:disable Metrics/ParameterLists
      columns,
      table_name,
      only: nil,
      except: nil,
      formats: nil,
      links: nil,
      attrs: nil,
      header_attrs: nil
    )
      @columns = columns
      @table_name = table_name
      @only = only || []
      @except = except || []
      @formats = formats || {}
      @links = links || {}
      @attrs = attrs || {}
      @header_attrs = header_attrs || {}
    end

    # set and get table name
    # @param [Symbol] table_name
    # @return [Symbol]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.table_name :foos
    def table_name(table_name = nil)
      if table_name
        @table_name = table_name
      else
        @table_name
      end
    end

    # add only columns
    # @param [Array<Symbol>] columns
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.only :id, :name
    #     - s.only :foo_id
    def only(*columns)
      @only += columns.flatten
    end

    # add except columns
    # @param [Array<Symbol>] columns
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.except :created_at, :updated_at
    #     - s.except :password
    def except(*columns)
      @except += columns.flatten
    end

    # set column format
    # @param [Symbol] column target column
    # @param [Proc|Symbol|Array<Symbol|Array<Symbol>>] format format
    # @yield [record] format function (optional)
    # @yieldparam [Object] record record
    # @yieldreturn [String] formatted value
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.only :id, :foo_id, :statuses
    #     - s.format :foo_id, [:foo_id, [:foo, :name]]
    #     - s.format :statuses do |record|
    #       ul
    #         - record.statuses.split(" ") each do |status|
    #           li = status
    def format(column, format = nil, &block)
      @formats[column] = block_given? ? block : format
    end

    # set column link setting
    # @param [Symbol] column target column
    # @param [Symbol|Hash<Symbol|Array<Symbol|Array<Symbol>>>] link setting
    # @yield [record] format function (optional)
    # @yieldparam [Object] record record
    # @yieldreturn [String] link uri string
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.link :foo_id, :foo_path
    #     - s.link :id, foo_bar_path: [:foo_id, :id]
    #     - s.link(:bar_id) {|record| baz_path(record.bar_id) }
    def link(column, link = nil, &block)
      @links[column] = block_given? ? block : link
    end

    # set column value dom tag attrs
    # @param [Symbol] column target column
    # @param [Hash<Symbol, String>] attr attr hash
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.attr :foo_id, style: "width: 4em"
    def attr(column, attr)
      @attrs[column] = attr
    end

    # set column header dom tag attrs
    # @param [Symbol] column target column
    # @param [Hash<Symbol, String>] header_attr attr hash
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.header_attr :foo_id, style: "font-weight: bold"
    def header_attr(column, header_attr)
      @header_attrs[column] = header_attr
    end

    # set column
    # @param [Symbol] column target column
    # @param [Proc|Symbol|Array<Symbol|Array<Symbol>>] format format
    # @param [Symbol|Hash<Symbol|Array<Symbol|Array<Symbol>>>] link setting
    # @param [Hash<Symbol, String>] attr column value dom tag attrs
    # @param [Hash<Symbol, String>] header_attr column header dom tag attrs
    # @return [void]
    #
    # @example
    #   = dl_for(record) do |s|
    #     - s.column :foo_id, format: [:foo_id, [:foo, :name]], link: :foo_path
    def column(column, format: nil, link: nil, attr: nil, header_attr: nil)
      @formats[column] if format
      @links[column] if link
      @attrs[column] if attr
      @header_attrs[column] = header_attr if header_attr
    end

    # calculated columns
    # @return [Array<Symbol>] (only || default columns) - except
    def columns
      (@only.presence || @columns).map(&:to_sym).without(*@except.map(&:to_sym))
    end
  end
end
