class Area < ApplicationRecord
  has_many :posts
  has_many :area_mappings
end
