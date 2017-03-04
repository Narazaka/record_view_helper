require "rails_helper"

RSpec.describe TestsController, type: :controller do
  describe "setting working" do
    it do
      get :true
      expect(response.body).to eq "true"
    end

    it do
      get :false
      expect(response.body).to eq "(false)"
    end
  end
end
