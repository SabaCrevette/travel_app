require 'rails_helper'

RSpec.describe User, type: :model do
  # describe 'バリデーションチェック' do
  #   context 'パスワードが存在する' do
  #   end
  # end
end

# create_table "users", force: :cascade do |t|
#   t.string "name", null: false
#   t.string "email", null: false
#   t.string "crypted_password"
#   t.integer "role", default: 0
#   t.integer "public_status", default: 0
#   t.string "salt"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "avatar"
#   t.string "reset_password_token"
#   t.datetime "reset_password_token_expires_at"
#   t.datetime "reset_password_email_sent_at"
#   t.integer "access_count_to_reset_password_page", default: 0
#   t.bigint "category_id"
#   t.bigint "prefecture_id"
#   t.index ["category_id"], name: "index_users_on_category_id"
#   t.index ["email"], name: "index_users_on_email", unique: true
#   t.index ["prefecture_id"], name: "index_users_on_prefecture_id"
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
# end