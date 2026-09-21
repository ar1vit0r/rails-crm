class Contact < ApplicationRecord
  belongs_to :user
  has_many :leads, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true

  enum :status, { lead: "lead", prospect: "prospect", customer: "customer" }

  # LOWER() on both sides because a bare LIKE is case-sensitive on Postgres
  # (production) but not on SQLite (dev/test). ESCAPE makes the escaped % and _
  # literal on both adapters.
  scope :search, ->(term) {
    pattern = "%#{sanitize_sql_like(term)}%"
    where("LOWER(name) LIKE LOWER(:pattern) ESCAPE '\\' OR LOWER(company) LIKE LOWER(:pattern) ESCAPE '\\'", pattern: pattern)
  }
end
