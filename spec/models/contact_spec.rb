require "rails_helper"

RSpec.describe Contact, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:leads).dependent(:destroy) }
    it { should have_many(:activities).dependent(:destroy) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:contact)).to be_valid
    end
  end
end
