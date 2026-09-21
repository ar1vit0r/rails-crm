require "rails_helper"

RSpec.describe LeadsHelper, type: :helper do
  describe "#stage_border" do
    it "maps every lead status to a border class" do
      Lead.statuses.each_key do |status|
        expect(helper.stage_border(status)).to start_with("border-l-stage-")
        expect(helper.stage_bg(status)).to start_with("bg-stage-")
      end
    end
  end

  describe "#stage_label" do
    it "drops the new_lead suffix" do
      expect(helper.stage_label("new_lead")).to eq("New")
    end
  end

  describe "#priority_pips" do
    it "fills pips up to the priority level and labels it for screen readers" do
      html = helper.priority_pips(build(:lead, priority: "medium"))

      expect(html).to include("Medium priority")
      expect(html.scan("bg-bone").size).to eq(2)
      expect(html.scan("bg-gray-600").size).to eq(1)
    end

    it "omits the screen-reader label when announce is false" do
      html = helper.priority_pips(build(:lead, priority: "medium"), announce: false)

      expect(html).not_to include("sr-only")
    end
  end
end
