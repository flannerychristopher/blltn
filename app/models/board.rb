class Board < ApplicationRecord
  has_many :memberships,  dependent: :destroy
  has_many :users,        through:   :memberships
  has_many :posts,        dependent: :destroy

  validates :name,  presence: true,   length: { maximum: 75 }
  validates :info,  presence: true,   length: { maximum: 255 }
end
