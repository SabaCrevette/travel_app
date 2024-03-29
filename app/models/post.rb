require_dependency 'concerns/addressable'

class Post < ApplicationRecord
  include Addressable

  belongs_to :user
  belongs_to :prefecture, optional: true
  belongs_to :city, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  belongs_to :area, optional: true

  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  # Geocoder configuration
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.location_changed? || obj.prefecture_id_changed? }
  after_validation :save_formatted_address, if: ->(obj) { obj.location_changed? || obj.prefecture_id_changed? }

  after_create :increment_user_prefecture_post_count
  after_destroy :decrement_user_prefecture_post_count
  before_update :adjust_prefecture_post_count, if: :prefecture_changed?

  # 以前と新しい都道府県のカウントを調整
  def adjust_prefecture_post_count
    # 以前の都道府県を取得し、カウントを減らす
    old_prefecture = UserPrefecture.find_by(user:, prefecture_id: prefecture_id_was)
    old_prefecture.decrement!(:post_count) if old_prefecture.present?

    # 新しい都道府県を取得し、カウントを増やす
    new_prefecture = UserPrefecture.find_or_create_by(user:, prefecture_id:)
    new_prefecture.increment!(:post_count)
  end

  before_save :set_area_id, if: ->(obj) { obj.will_save_change_to_address? }

  attr_accessor :images_cache

  mount_uploaders :images, ImageUploader

  validates :prefecture_id, presence: true
  validates :location, presence: true, length: { maximum: 30 }
  validates :text, presence: true, length: { maximum: 100 }
  validate :images_count_within_limit
  validate :validate_tags_count

  enum event_status: { permanent: 0, seasonal: 1 }
  enum public_status: { open: 0, closed: 1 }

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }
  scope :by_status, lambda { |user|
    if user
      includes(:user, :prefecture, :tags)
        .where('posts.user_id = :user_id OR posts.public_status = :public_status', user_id: user.id, public_status: public_statuses[:open])
    else
      includes(:user, :prefecture, :tags)
        .where(public_status: public_statuses[:open])
    end
  }
  scope :exclude_unvisited_prefectures, lambda { |user|
    return all unless user

    visited_prefecture_ids = user.posts.select(:prefecture_id).distinct.pluck(:prefecture_id)
    where.not(prefecture_id: visited_prefecture_ids)
  }

  def self.posts_count_by_prefecture
    group(:prefecture_id).count
  end

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

  def full_address
    prefecture_name = Prefecture.find(prefecture_id).name
    [prefecture_name, location].compact.join(' ')
  end

  def save_formatted_address
    return unless geocoded?

    formatted = Geocoder.search([latitude, longitude], language: :ja).first.formatted_address
    # '289F+GC 日本、' のような形式を削除
    formatted = formatted.sub(/^\w+\+\w+\s日本、\s*/, '')
    # '日本、' を削除
    self.address = formatted.sub(/^日本、\s*/, '')
  end
end
