require "active_support/core_ext/object/try"

module RecordViewHelper
  # build table for records
  # @param [Enumerable<Object>] records records
  # @param [Hash] options
  # @yield [setting] optional setting block (see RecordValueSetting document)
  # @yieldparam [RecordValueSetting] setting setting object
  # @yieldreturn [void]
  # @return [ActiveSupport::SafeBuffer] rendered result
  #
  # @example basic
  #   = table_for(records)
  #
  # @example only columns
  #   = table_for(records, only: [:id, :name])
  #   / only :id, :name columns will rendered
  #
  # @example except columns
  #   = table_for(records, except: [:created_at, :updated_at])
  #   / except timestamp columns
  #
  # @example link settings
  #   = table_for(records, links: {id: :foo_path})
  #   / link to foo_path(record.id)
  #
  # @example nested path link
  #   = table_for(records, links: {id: {foo_bar_path: [:foo_id, :id]}})
  #   / link to foo_bar_path(record.foo_id, record.id)
  #
  # @example formats
  #   = table_for(records, formats: {foo_id: [:foo_id, [:foo, :name]]})
  #   / foo_id column will rendered as "#{foo_id} #{foo.name}"
  #
  # @example proc formats
  #   = table_for(records, formats: {statuses: ->(record) { record.statuses.join(" ") } })
  #   / you can use also free format
  #
  # @example column header locale
  #   = table_for(records, table_name: "foos")
  #   / table header will rendered by t("record_view_helper.#{table_name}.columns.#{column}")
  #   / table_name is automatically detected from record class name by default
  #   / if you want to change locale namespace, see RecordViewHelper::Config document
  #
  # @example attrs / header attrs
  #   = table_for(records, attrs: {id: {style: "width: 3em"}}, header_attrs: {id: {style: "width: 3em"}})
  #   / td(attrs) and th(header_attrs) attrs
  #
  # @example table attrs
  #   = table_for(records, width: "100%")
  #   / <table width="100%">
  #
  # @example setting block
  #   = table_for(records) do |s|
  #     - s.only :id, :name
  #   / recommended for complex settings
  #   / see RecordValueSetting for details
  def table_for(records, options = {}) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    setting = RecordValueSetting.build_from_hash!(
      records.try(:klass).try(:column_names) || records.first.try(:attributes).try(:keys) || records.first.try(:keys) || [],
      records.first.try(:class).try(:name).try(:tableize),
      options,
    )
    yield setting if block_given?
    content_tag(
      "table",
      safe_join([
        content_tag(
          "thead",
          content_tag(
            "tr",
            safe_join(
              setting.columns.map do |column|
                content_tag("th", record_view_helper_t(records.first.class, column), setting.header_attrs[column])
              end,
            ),
          ),
        ),
        content_tag(
          "tbody",
          safe_join(
            records.map do |record|
              content_tag(
                "tr",
                safe_join(
                  setting.columns.map do |column|
                    content_tag("td", format_record_value(record, column, setting.formats[column], setting.links[column]), setting.attrs[column])
                  end,
                ),
              )
            end,
          ),
        ),
      ]),
      options,
    )
  end
end
