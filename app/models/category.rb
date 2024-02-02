class Category < ApplicationRecord
  has_many :users

  # 中間テーブルを介してタグを持つ
  has_many :category_tags
  has_many :tags, through: :category_tags
end
