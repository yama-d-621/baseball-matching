class Offer < ApplicationRecord
  validates :game_date, presence: true
  validates :area, presence: true, length: { maximum: 50 }
  validates :ground, presence: true, length: { maximum: 50 }
  
  belongs_to :user
  has_many :applications
  has_many :app_users, through: :applications, source: :user
end
