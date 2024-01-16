class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, length: { maximum: 10 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name] # 検索可能な属性を指定（ここでは'name'属性のみ）
  end
end
