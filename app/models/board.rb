class Board < ApplicationRecord
  has_many :memberships
  has_many :users,      through: :memberships

  validates :name,  presence: true,   length: { maximum: 75 }
  validates :info,  presence: true,   length: { maximum: 255 }
end
