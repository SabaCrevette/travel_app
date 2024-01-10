class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 一意性のスコープ付きバリデーションを追加
  validates :user_id, uniqueness: { scope: :post_id }
end
