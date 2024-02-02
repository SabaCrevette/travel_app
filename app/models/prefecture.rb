class Prefecture < ApplicationRecord
  has_many :posts
  has_many :user_prefectures
  has_many :users, through: :user_prefectures
  has_many :users
  belongs_to :region, optional: true
end
