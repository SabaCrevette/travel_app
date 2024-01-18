class User < ApplicationRecord
  authenticates_with_sorcery!

  # パスワード更新時に、パスワードとパスワード確認のどちらも入力されていなければ、パスワードの更新処理を行わないようにする
  before_validation :skip_password_validation, on: :update

  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :user_prefectures
  has_many :prefectures, through: :user_prefectures
  mount_uploader :avatar, AvatarUploader

  attr_accessor :password, :password_confirmation

  validates :password, presence: true, length: { minimum: 3 }, confirmation: true, if: :should_validate_password?
  validates :password_confirmation, presence: true, if: :should_validate_password?
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def bookmark(post)
    bookmark_posts << post
  end

  def unbookmark(post)
    bookmark_posts.delete(post)
  end

  def bookmark?(post)
    bookmark_posts.include?(post)
  end

  private

  def should_validate_password?
    password.present? || password_confirmation.present?
  end

  def skip_password_validation
    return unless password.blank? && password_confirmation.blank?

    self.password = self.password_confirmation = nil
  end
end
