require "rails_helper"

RSpec.describe Lead, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
  end

  describe "associations" do
    it { should belong_to(:contact) }
    it { should belong_to(:user) }
    it { should have_many(:activities).dependent(:destroy) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:lead)).to be_valid
    end
  end
end
