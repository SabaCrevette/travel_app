require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq mypage_path
      end
    end

    
    context 'フォームの入力値が不正' do
      it '登録されていないアカウントでログインが失敗する' do
        visit login_path
        fill_in 'Email', with: 'aaa@aaa'
        fill_in 'Password', with: 'aaa'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path
      end
      it 'Emailが空の場合にログインが失敗する' do
        visit login_path
        fill_in 'Email', with: nil
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path
      end
      it 'Passwordが空の場合にログインが失敗する' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: nil
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    it 'ログアウトボタンを押下するとログアウトする' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
      expect(current_path).to eq mypage_path
      click_link 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
      expect(current_path).to eq root_path
    end
  end
end
