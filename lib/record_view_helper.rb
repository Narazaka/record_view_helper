require "action_view"
require "active_support/concern"
require "record_view_helper/config"
require "record_view_helper/dl"
require "record_view_helper/table"
require "record_view_helper/record_value_setting"
require "record_view_helper/util"
require "record_view_helper/version"

require "record_view_helper/railtie" if defined?(Rails)

# table builder and description list (dl) helper for Rails / ActiveModels
module RecordViewHelper
  extend ActiveSupport::Concern
  include ::ActionView::Helpers::TagHelper
  include ::ActionView::Helpers::UrlHelper
  include ::ActionView::Helpers::TextHelper
  include ::ActionView::Helpers::TranslationHelper

  included do
    class << self
      # config
      # @return [RecordViewHelper::Config]
      attr_accessor :record_view_helper_config
    end
    self.record_view_helper_config ||= Config.new
  end

  # config
  # @return [RecordViewHelper::Config]
  def record_view_helper_config
    self.class.send(__method__) || Rails.application.config.record_view_helper
  end
end
