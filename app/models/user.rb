class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :offers
  has_many :applications
  has_many :app_offers, through: :applications, source: :offer
  
  mount_uploader :image, ImageUploader
  
  def apply(other_offer)
    unless self.offer == other_offer
      self.applications.find_or_create_by(offer_id: other_offer.id)
    end
  end
  
  def apply?(other_offer)
    self.applications.include?(other_offer)
  end
end
