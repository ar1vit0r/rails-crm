require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /" do
    context "when logged in" do
      let(:user) { create(:user) }
      before { sign_in user }

      it "returns http success" do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end

    context "when not logged in" do
      it "returns http success (landing page)" do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
