require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:bookmark) { build(:bookmark, user: user, post: post) }

    it 'user_idとpost_idがあれば有効であること' do
      expect(bookmark).to be_valid
    end

    it 'user_idがなければ無効であること' do
      bookmark.user = nil
      bookmark.valid?
      expect(bookmark.errors[:user]).to include('を入力してください')
    end

    it 'post_idがなければ無効であること' do
      bookmark.post = nil
      bookmark.valid?
      expect(bookmark.errors[:post]).to include('を入力してください')
    end

    it 'user_idとpost_idの組み合わせは一意であること' do
      create(:bookmark, user: user, post: post)
      duplicate_bookmark = build(:bookmark, user: user, post: post)
      duplicate_bookmark.valid?
      expect(duplicate_bookmark.errors[:user_id]).to include('はすでに存在します')
    end
  end

  describe 'アソシエーションのテスト' do
    it 'Userモデルと関連していること' do
      expect(Bookmark.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'Postモデルと関連していること' do
      expect(Bookmark.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
  end
end



# create_table "bookmarks", force: :cascade do |t|
#   t.bigint "user_id"
#   t.bigint "post_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["post_id"], name: "index_bookmarks_on_post_id"
#   t.index ["user_id", "post_id"], name: "index_bookmarks_on_user_id_and_post_id", unique: true
#   t.index ["user_id"], name: "index_bookmarks_on_user_id"
# end