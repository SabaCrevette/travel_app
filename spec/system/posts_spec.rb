require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    it 'ログインページにリダイレクトされる' do
      visit new_post_path
      expect(current_path).to eq login_path
    end
  end

  

  describe 'ログイン後' do
    before do
      login_as(user)
      visit new_post_path
    end

    context '投稿に成功する場合' do
      it '投稿画像1枚で成功する(jpg)' do

      end
      it '投稿画像4枚で成功する(jpg)' do

      end
      it 'タグ未入力で成功する' do

      end
      it 'タグ1個入力で成功する' do

      end
      it 'タグ5個入力で成功する' do

      end
    end

    context '投稿に失敗する場合' do
      it '都道府県が未選択' do
        
      end
      it '観光地・スポットが未選択' do

      end
      it '画像を未選択' do

      end
      it '画像が5枚以上選択' do

      end
      it 'タグが6個以上' do

      end
    end
  end
end
