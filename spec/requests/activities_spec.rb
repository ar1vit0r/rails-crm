require "rails_helper"

RSpec.describe "Activities", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:contact) { create(:contact, user: user) }
  let(:other_contact) { create(:contact, user: other_user) }

  before { sign_in user }

  describe "GET /activities/:id" do
    it "returns http success" do
      activity = create(:activity, contact: contact, user: user)
      get activity_path(activity)
      expect(response).to have_http_status(:ok)
    end

    it "returns 404 for other user's activity" do
      activity = create(:activity, contact: other_contact, user: other_user)
      get activity_path(activity)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /contacts/:contact_id/activities" do
    it "creates an activity" do
      expect {
        post contact_activities_path(contact), params: { activity: { kind: "note", body: "Test note", performed_at: Time.current } }
      }.to change(Activity, :count).by(1)
      expect(response).to redirect_to(contact_path(contact))
    end

    it "returns 422 with invalid params" do
      post contact_activities_path(contact), params: { activity: { kind: "", body: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /activities/:id" do
    it "updates the activity" do
      activity = create(:activity, contact: contact, user: user)
      patch activity_path(activity), params: { activity: { body: "Updated note" } }
      expect(activity.reload.body).to eq("Updated note")
    end

    it "returns 404 for other user's activity" do
      activity = create(:activity, contact: other_contact, user: other_user)
      patch activity_path(activity), params: { activity: { body: "Hacked" } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /activities/:id" do
    it "deletes the activity" do
      activity = create(:activity, contact: contact, user: user)
      expect {
        delete activity_path(activity)
      }.to change(Activity, :count).by(-1)
      expect(response).to redirect_to(contact_path(contact))
    end

    it "returns 404 for other user's activity" do
      activity = create(:activity, contact: other_contact, user: other_user)
      delete activity_path(activity)
      expect(response).to have_http_status(:not_found)
    end
  end
end
