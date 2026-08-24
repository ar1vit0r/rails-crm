class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :leads, dependent: :destroy
  has_many :activities, dependent: :destroy

  def admin?
    role == "admin"
  end
end
