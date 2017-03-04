require "spec_helper"

describe RecordViewHelper::RecordValueSetting do
  describe "#columns" do
    let(:setting) { RecordViewHelper::RecordValueSetting.new(columns, table_name, only: only, except: except) }
    let(:table_name) { "table" }
    let(:columns) { [:col1, :col2] }
    let(:only) { nil }
    let(:except) { nil }
    subject { setting.columns }

    context "plain columns" do
      it { is_expected.to eq [:col1, :col2] }
    end

    context "only" do
      let(:only) { [:col1, :o1, :o2] }
      it { is_expected.to eq [:col1, :o1, :o2] }
    end

    context "except" do
      let(:except) { [:o1, :col1] }
      it { is_expected.to eq [:col2] }
    end

    context "only and except" do
      let(:only) { [:col1, :o1, :o2] }
      let(:except) { [:o1, :col1] }
      it { is_expected.to eq [:o2] }
    end
  end
end
