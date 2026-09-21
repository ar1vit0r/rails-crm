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

  describe ".search" do
    let!(:john) { create(:contact, name: "John Doe", company: "Acme Co") }
    let!(:jane) { create(:contact, name: "Jane Smith", company: "Globex") }

    it "matches name and company case-insensitively" do
      expect(Contact.search("jOHN")).to contain_exactly(john)
      expect(Contact.search("gLoBeX")).to contain_exactly(jane)
    end

    it "treats % and _ as literal characters, not wildcards" do
      pct = create(:contact, name: "50% Off Inc", company: nil)

      expect(Contact.search("%")).to contain_exactly(pct)
      expect(Contact.search("_")).to be_empty
    end

    # SQLite's LIKE ignores case on its own, so the behavior specs above cannot
    # catch a bare LIKE coming back; Postgres (production) would then go case-sensitive.
    it "lowercases both sides in SQL so it stays portable to Postgres" do
      sql = Contact.search("x").to_sql

      expect(sql).to include("LOWER(name) LIKE LOWER(", "LOWER(company) LIKE LOWER(")
    end
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:contact)).to be_valid
    end
  end
end
