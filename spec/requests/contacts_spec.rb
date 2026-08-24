require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /contacts" do
    it "returns http success" do
      get contacts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /contacts/:id" do
    it "returns http success" do
      contact = create(:contact, user: user)
      get contact_path(contact)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /contacts" do
    it "creates a contact" do
      expect {
        post contacts_path, params: { contact: { name: "John Doe", email: "john@example.com", company: "Acme" } }
      }.to change(Contact, :count).by(1)
      expect(response).to redirect_to(contact_path(Contact.last))
    end
  end

  describe "PATCH /contacts/:id" do
    it "updates the contact" do
      contact = create(:contact, user: user)
      patch contact_path(contact), params: { contact: { name: "Jane Doe" } }
      expect(contact.reload.name).to eq("Jane Doe")
    end
  end

  describe "DELETE /contacts/:id" do
    it "deletes the contact" do
      contact = create(:contact, user: user)
      expect {
        delete contact_path(contact)
      }.to change(Contact, :count).by(-1)
      expect(response).to redirect_to(contacts_path)
    end
  end
end
