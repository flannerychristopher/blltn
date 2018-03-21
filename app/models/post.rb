class Post < ApplicationRecord
  belongs_to :user
  belongs_to :board

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :board_id, presence: true

  def self.today
    where('created_at >= ?', 1.day.ago)
  end
end
