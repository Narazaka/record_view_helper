require "spec_helper"
require "view_and_model_helper"

MyView.record_view_helper_config ||= RecordViewHelper::Config.new
MyView.record_view_helper_config.false_view = "(false)"

describe RecordViewHelper do
  let(:context) { MyView.new(nil, locals) }
  let(:locals) { {} }
  let(:expect_rendered) { context.render(inline: expect_template) }
  subject { context.render(inline: template) }

  describe "#format_view_value" do
    context Time do
      let(:template) { "<%= format_view_value(Time.new(2000, 1, 1)) %>" }
      let(:expect_template) { "<%= l(Time.new(2000, 1, 1)) %>" }
      it { is_expected.to eq expect_rendered }
    end

    context true do
      let(:template) { "<%= format_view_value(true) %>" }
      let(:expect_template) { "true" }
      it { is_expected.to eq expect_rendered }
    end

    context false do
      let(:template) { "<%= format_view_value(false) %>" }
      let(:expect_template) { "(false)" }
      it { is_expected.to eq expect_rendered }
    end

    context String do
      let(:template) { "<%= format_view_value('foo') %>" }
      let(:expect_template) { "foo" }
      it { is_expected.to eq expect_rendered }
    end

    context Integer do
      let(:template) { "<%= format_view_value(42) %>" }
      let(:expect_template) { "42" }
      it { is_expected.to eq expect_rendered }
    end

    context "nil" do
      let(:template) { "<%= format_view_value(nil) %>" }
      let(:expect_template) { "" }
      it { is_expected.to eq expect_rendered }
    end
  end

  describe "#deep_record_value" do
    let(:record) { Bar.new(101, "bar", Foo.new(1, "foo")) }
    let(:locals) { { record: record } }

    context "simple" do
      let(:template) { "<%= deep_record_value(@record, :name) %>" }
      let(:expect_template) { "bar" }
      it { is_expected.to eq expect_rendered }
    end

    context "deep" do
      let(:template) { "<%= deep_record_value(@record, [:foo, :name]) %>" }
      let(:expect_template) { "foo" }
      it { is_expected.to eq expect_rendered }
    end
  end

  describe "#deep_record_values" do
    let(:record) { Bar.new(101, "bar", Foo.new(1, "foo")) }
    let(:locals) { { record: record } }

    let(:template) { "<%= deep_record_values(@record, [:name, [:foo, :name]]).join(' ') %>" }
    let(:expect_template) { "bar foo" }
    it { is_expected.to eq expect_rendered }
  end

  describe "#link_record_value" do
    let(:locals) { { record: record } }

    context "simple" do
      let(:record) { Foo.new(1, "foo") }
      let(:template) { "<%= link_record_value(@record, 'link', :foo_path, :id) %>" }
      let(:expect_template) { "<%= link_to 'link', foo_path(@record.id) %>" }
      it { is_expected.to eq expect_rendered }
    end

    context "deep" do
      let(:record) { Bar.new(101, "bar", Foo.new(1, "foo")) }
      let(:template) { "<%= link_record_value(@record, 'link', :foo_bar_path, [[:foo, :id], :id]) %>" }
      let(:expect_template) { "<%= link_to 'link', foo_bar_path(@record.foo.id, @record.id) %>" }
      it { is_expected.to eq expect_rendered }
    end
  end

  describe "#format_record_value" do
    let(:record) { Foo.new(1, "foo") }
    let(:locals) { { record: record } }

    context "plain" do
      let(:template) { "<%= format_record_value(@record, :name) %>" }
      let(:expect_template) { "foo" }
      it { is_expected.to eq expect_rendered }
    end

    context "simple format" do
      let(:template) { "<%= format_record_value(@record, :name, [:id, :name]) %>" }
      let(:expect_template) { "1 foo" }
      it { is_expected.to eq expect_rendered }
    end

    context "proc format" do
      let(:template) { "<%= format_record_value(@record, :name, Proc.new { |r| concat r.id + 1 }) %>" }
      let(:expect_template) { "2" }
      it { is_expected.to eq expect_rendered }
    end

    context "simple link" do
      let(:template) { "<%= format_record_value(@record, :id, nil, :foo_path) %>" }
      let(:expect_template) { '<%= link_to "#{@record.id}", foo_path(@record.id) %>' }
      it { is_expected.to eq expect_rendered }
    end

    context "deep link" do
      let(:template) { "<%= format_record_value(@record, :id, nil, foo_bar_path: [:name, :id]) %>" }
      let(:expect_template) { '<%= link_to "#{@record.id}", foo_bar_path(@record.name, @record.id) %>' }
      it { is_expected.to eq expect_rendered }
    end
  end
end
