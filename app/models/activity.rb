class Activity < ApplicationRecord
  belongs_to :contact
  belongs_to :lead, optional: true
  belongs_to :user

  validates :kind, presence: true
  validates :body, presence: true

  enum :kind, { note: "note", call: "call", email: "email", meeting: "meeting" }
end
