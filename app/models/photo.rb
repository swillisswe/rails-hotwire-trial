class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :photographer, presence: true
  validates :image_url, presence: true
  validates :source_url, presence: true, uniqueness: true

  def liked_by?(user)
    return false unless user

    likes.exists?(user: user)
  end
end
