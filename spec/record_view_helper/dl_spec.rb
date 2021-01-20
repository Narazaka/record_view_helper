require "spec_helper"
require "view_and_model_helper"

describe RecordViewHelper do
  let(:context) { MyView.new(build_lookup_context, locals, nil) }
  let(:locals) { { record: record } }
  subject { context.render(inline: template) }

  describe "#dl_for" do
    let(:record) { Foo.new(1, "foo") }
    let(:template) { "<%= dl_for(@record, only: [:id, :name]) %>" }
    it { is_expected.to match(/foo/) }
  end
end
