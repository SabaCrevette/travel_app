class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture, optional: true
  has_many :post_tags
  has_many :tags, through: :post_tags

  attr_accessor :images_cache

  mount_uploaders :images, ImageUploader

  validates :prefecture_id, presence: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 100 }
  validate :images_count_within_limit
  validate :validate_tags_count

  enum event_status: { permanent: 0, seasonal: 1 }
  enum public_status: { open: 0, closed: 1 }

  private

  def images_count_within_limit
    if images.length > 4
      errors.add(:images, 'は最大4枚までです')
    end

    return unless images.empty? && images_cache.blank?

    errors.add(:images, 'を最低1枚選んでください')
  end

  def validate_tags_count
    errors.add(:tags, 'の数は5個までです') if tags.size > 5
  end
end
