class AddRegionIdToPrefectures < ActiveRecord::Migration[7.1]
  def change
    add_reference :prefectures, :region, null: true, foreign_key: true
  end
end
