require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) } # Userを事前に作成
  let!(:prefecture) { Prefecture.create(name: '北海道') } # 事前に都道府県を作成

  describe 'バリデーションチェック' do
    context '必須項目が全て入力されている場合' do
      let(:post) { build(:post, user: user, prefecture: prefecture, images: [fixture_file_upload('sample1.jpeg', 'image/jpeg')]) }

      it '投稿が有効であること' do
        expect(post).to be_valid
      end
    end

    context 'locationが空の場合' do
      let(:post) { build(:post, user: user, prefecture: prefecture, location: '', images: [fixture_file_upload('sample1.jpeg', 'image/jpeg')]) }

      it '投稿が無効であること' do
        expect(post).not_to be_valid
        expect(post.errors[:location]).to include("を入力してください")
      end
    end

    context 'textが空の場合' do
      let(:post) { build(:post, user: user, prefecture: prefecture, text: '', images: [fixture_file_upload('sample1.jpeg', 'image/jpeg')]) }

      it '投稿が無効であること' do
        expect(post).not_to be_valid
        expect(post.errors[:text]).to include("を入力してください")
      end
    end
  end

  describe 'デフォルト値の検証' do
    let(:post) { build(:post, prefecture: prefecture) }

    it 'event_statusがデフォルトで0に設定されていること' do
      expect(post.event_status).to eq("permanent") # enumのキーに修正
    end

    it 'public_statusがデフォルトで0に設定されていること' do
      expect(post.public_status).to eq("open") # enumのキーに修正
    end
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