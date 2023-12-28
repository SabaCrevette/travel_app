class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture, optional: true

  validates :prefecture_id, presence: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 100 }

  enum event_status: { permanent: 0, seasonal: 1 }
  enum public_status: { open: 0, closed: 1 }
end
