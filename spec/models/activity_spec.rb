require "rails_helper"

RSpec.describe Activity, type: :model do
  describe "validations" do
    it { should validate_presence_of(:kind) }
    it { should validate_presence_of(:body) }
  end

  describe "associations" do
    it { should belong_to(:contact) }
    it { should belong_to(:lead).optional }
    it { should belong_to(:user) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:activity)).to be_valid
    end
  end
end
