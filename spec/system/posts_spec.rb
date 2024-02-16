require 'rails_helper'

RSpec.describe "Posts", type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let!(:prefecture) { Prefecture.create(name: '北海道') } # 事前に都道府県を作成しておく

  describe 'ログイン前' do
    it 'ログインページにリダイレクトされる' do
      visit new_post_path
      expect(current_path).to eq login_path
    end
  end

  

  describe 'ログイン後' do
    before do
      login_as(user)
      sleep(3) # 3秒待機
      visit new_post_path
    end

    context '投稿に成功する場合' do
      let(:image_path) { Rails.root.join('spec/fixtures/files/sample1.jpeg') }
      let(:image_paths) { 
        [
          Rails.root.join('spec/fixtures/files/sample1.jpeg'),
          Rails.root.join('spec/fixtures/files/sample2.jpeg'),
          Rails.root.join('spec/fixtures/files/sample3.jpeg'),
          Rails.root.join('spec/fixtures/files/sample4.jpeg')
        ] 
      }
      it '投稿画面にアクセスできている' do
        expect(current_path).to eq new_post_path
        expect(page).to have_selector('select#post_prefecture_id') # ここでセレクトボックスの存在を確認
      end
      xit '投稿画像1枚で成功する(jpg)' do
        fill_in 'post[location]', with: '富良野ラベンダー畑'
        fill_in 'post[text]', with: 'めちゃくちゃ綺麗'
        attach_file('post[images][]', image_path, visible: false) # 修正: visible: falseオプションを使用
        select '北海道', from: 'post[prefecture_id]' # ここでプルダウンから選択
        click_button '投稿する'
        sleep(5) # 3秒待機
        # 投稿の作成が完了した後に投稿オブジェクトを取得
        post = Post.order(created_at: :desc).first
        # リダイレクト後のパスが投稿のパスと一致することを検証
        expect(current_path).to eq post_path(post)
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
