require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in user }

  describe "GET /contacts" do
    it "returns http success" do
      get contacts_path
      expect(response).to have_http_status(:ok)
    end

    it "filters by search term" do
      create(:contact, user: user, name: "John Doe")
      create(:contact, user: user, name: "Jane Smith")

      get contacts_path, params: { search: "John" }
      expect(response).to have_http_status(:ok)
    end

    it "filters by status" do
      create(:contact, user: user, status: "lead")
      create(:contact, user: user, status: "customer")

      get contacts_path, params: { status: "lead" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /contacts/:id" do
    it "returns http success" do
      contact = create(:contact, user: user)
      get contact_path(contact)
      expect(response).to have_http_status(:ok)
    end

    it "returns 404 for other user's contact" do
      contact = create(:contact, user: other_user)
      get contact_path(contact)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /contacts" do
    it "creates a contact" do
      expect {
        post contacts_path, params: { contact: { name: "John Doe", email: "john@example.com", company: "Acme" } }
      }.to change(Contact, :count).by(1)
      expect(response).to redirect_to(contact_path(Contact.last))
    end

    it "returns 422 with invalid params" do
      post contacts_path, params: { contact: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /contacts/:id" do
    it "updates the contact" do
      contact = create(:contact, user: user)
      patch contact_path(contact), params: { contact: { name: "Jane Doe" } }
      expect(contact.reload.name).to eq("Jane Doe")
    end

    it "returns 404 for other user's contact" do
      contact = create(:contact, user: other_user)
      patch contact_path(contact), params: { contact: { name: "Hacked" } }
      expect(response).to have_http_status(:not_found)
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

    it "returns 404 for other user's contact" do
      contact = create(:contact, user: other_user)
      delete contact_path(contact)
      expect(response).to have_http_status(:not_found)
    end
  end
end
