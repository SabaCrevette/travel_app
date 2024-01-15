class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  after_create :increment_user_prefecture_post_count
  after_destroy :decrement_user_prefecture_post_count

  attr_accessor :images_cache

  mount_uploaders :images, ImageUploader

  validates :prefecture_id, presence: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 100 }
  validate :images_count_within_limit
  validate :validate_tags_count

  enum event_status: { permanent: 0, seasonal: 1 }
  enum public_status: { open: 0, closed: 1 }

  # タグ名に基づいて投稿をフィルタリングするクラスメソッド
  def self.with_tag(tag_name)
    # タグに関連する投稿を取得
    Tag.find_by(name: tag_name).posts
  end

  # タグに基づいて投稿を取得
  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  # 検索に含める関連付けを指定
  def self.ransackable_associations(_auth_object = nil)
    %w[prefecture tags]
  end

  # 検索に含める属性を指定
  def self.ransackable_attributes(auth_object = nil)
    super - %w[id created_at updated_at] # 除外したい属性をここで指定
  end

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

  def increment_user_prefecture_post_count
    user_prefecture = UserPrefecture.find_or_create_by(user:, prefecture:)
    user_prefecture.increment!(:post_count)
  end

  def decrement_user_prefecture_post_count
    user_prefecture = UserPrefecture.find_by(user:, prefecture:)
    user_prefecture.decrement!(:post_count) if user_prefecture.present?
  end
end
