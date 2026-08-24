class Lead < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  has_many :activities, dependent: :destroy

  validates :title, presence: true
  validates :status, presence: true

  enum :status, { new_lead: "new", qualified: "qualified", proposal: "proposal", won: "won", lost: "lost" }
  enum :priority, { low: 0, medium: 1, high: 2 }
end
