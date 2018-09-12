require "rails_helper"

RSpec.describe TestsController, type: :controller do
  describe "setting working" do
    it do
      get :true # rubocop:disable Lint/BooleanSymbol
      expect(response.body).to eq "true"
    end

    it do
      get :false # rubocop:disable Lint/BooleanSymbol
      expect(response.body).to eq "(false)"
    end
  end
end
