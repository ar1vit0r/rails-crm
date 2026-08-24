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

      it "displays total contacts count" do
        create(:contact, user: user)
        create(:contact, user: user)

        get root_path
        expect(response.body).to include("2")
      end

      it "displays total leads count" do
        contact = create(:contact, user: user)
        create(:lead, user: user, contact: contact)
        create(:lead, user: user, contact: contact)
        create(:lead, user: user, contact: contact)

        get root_path
        expect(response.body).to include("3")
      end

      it "displays pipeline value" do
        contact = create(:contact, user: user)
        create(:lead, user: user, contact: contact, status: "won", value: 10000)
        create(:lead, user: user, contact: contact, status: "won", value: 5000)

        get root_path
        expect(response.body).to include("15000")
      end

      it "displays conversion rate" do
        contact = create(:contact, user: user)
        create(:lead, user: user, contact: contact, status: "won")
        create(:lead, user: user, contact: contact, status: "lost")

        get root_path
        expect(response.body).to include("50")
      end
    end

    context "when not logged in" do
      it "returns http success (landing page)" do
        get root_path
        expect(response).to have_http_status(:ok)
      end

      it "displays sign up and login links" do
        get root_path
        expect(response.body).to include("Sign up")
        expect(response.body).to include("Login")
      end
    end
  end
end
