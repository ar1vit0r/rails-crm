require "rails_helper"

RSpec.describe "Leads", type: :request do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user: user) }

  before { sign_in user }

  describe "GET /leads" do
    it "returns http success" do
      get leads_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /leads/:id" do
    it "returns http success" do
      lead = create(:lead, user: user, contact: contact)
      get lead_path(lead)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /leads" do
    it "creates a lead" do
      expect {
        post leads_path, params: { lead: { title: "New Lead", contact_id: contact.id, status: "new", value: 5000 } }
      }.to change(Lead, :count).by(1)
      expect(response).to redirect_to(lead_path(Lead.last))
    end
  end

  describe "PATCH /leads/:id" do
    it "updates the lead" do
      lead = create(:lead, user: user, contact: contact)
      patch lead_path(lead), params: { lead: { status: "qualified" } }
      expect(lead.reload.status).to eq("qualified")
    end
  end

  describe "DELETE /leads/:id" do
    it "deletes the lead" do
      lead = create(:lead, user: user, contact: contact)
      expect {
        delete lead_path(lead)
      }.to change(Lead, :count).by(-1)
      expect(response).to redirect_to(leads_path)
    end
  end
end
