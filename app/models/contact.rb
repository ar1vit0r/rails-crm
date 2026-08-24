class Contact < ApplicationRecord
  belongs_to :user
  has_many :leads, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true

  enum :status, { lead: "lead", prospect: "prospect", customer: "customer" }
end
