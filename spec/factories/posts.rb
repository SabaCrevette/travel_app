FactoryBot.define do
  factory :post do
    sequence(:location, "location_1")
    text { "綺麗だった" }
  end
end




# create_table "posts", force: :cascade do |t|
#   t.bigint "user_id"
#   t.string "location", null: false
#   t.bigint "prefecture_id", null: false
#   t.string "text", null: false
#   t.integer "event_status", default: 0
#   t.integer "public_status", default: 0
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.json "images"
#   t.string "address"
#   t.float "latitude"
#   t.float "longitude"
#   t.bigint "area_id"
#   t.index ["area_id"], name: "index_posts_on_area_id"
#   t.index ["prefecture_id"], name: "index_posts_on_prefecture_id"
#   t.index ["user_id"], name: "index_posts_on_user_id"
# end