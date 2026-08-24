require "rails_helper"

RSpec.describe "Activities", type: :request do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user: user) }

  before { sign_in user }

  describe "GET /activities/:id" do
    it "returns http success" do
      activity = create(:activity, contact: contact, user: user)
      get activity_path(activity)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /contacts/:contact_id/activities" do
    it "creates an activity" do
      expect {
        post contact_activities_path(contact), params: { activity: { kind: "note", body: "Test note", performed_at: Time.current } }
      }.to change(Activity, :count).by(1)
      expect(response).to redirect_to(contact_path(contact))
    end
  end

  describe "PATCH /activities/:id" do
    it "updates the activity" do
      activity = create(:activity, contact: contact, user: user)
      patch activity_path(activity), params: { activity: { body: "Updated note" } }
      expect(activity.reload.body).to eq("Updated note")
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
  end
end
