require "spec_helper"
require "view_and_model_helper"

describe RecordViewHelper do
  let(:context) { MyView.new(nil, locals) }
  let(:locals) { { records: records } }
  subject { context.render(inline: template) }

  describe "#dl_for" do
    let(:records) { [Foo.new(1, "foo")] }
    let(:template) { "<%= table_for(@records, only: [:id, :name]) %>" }
    it { is_expected.to match(/foo/) }
  end
end
