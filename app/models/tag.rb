class Tag < ApplicationRecord
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :name, presence: true, length: { maximum: 10 }
end
