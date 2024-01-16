class City < ApplicationRecord
  belongs_to :prefecture
  geocoded_by :address # Cityモデルに定義されたaddress属性を基にジオコーディング
end
