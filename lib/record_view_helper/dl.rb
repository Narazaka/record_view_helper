module RecordViewHelper
  # build definition list(dl) for records
  #
  # the options is same as `table_for`
  # @param [Object] record record
  # @param [Hash] options (same as `table_for`)
  # @yield [setting] optional setting block (see RecordValueSetting document)
  # @yieldparam [RecordValueSetting] setting setting object
  # @yieldreturn [void]
  # @return [ActiveSupport::SafeBuffer] rendered result
  def dl_for(record, options = {})
    setting = RecordValueSetting.build_from_hash!(
      record.attributes.keys,
      record.class.name.tableize,
      options
    )
    yield setting if block_given?
    content_tag(
      "dl",
      safe_join(
        setting.columns.map do |column|
          safe_join [
            content_tag("dt", record_view_helper_t(setting.table_name, column), setting.header_attrs[column]),
            content_tag("dd", format_record_value(record, column, setting.formats[column], setting.links[column]), setting.attrs[column]),
          ]
        end
      ),
      options
    )
  end
end
