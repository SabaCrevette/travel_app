require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe '新規アカウント登録' do
    context 'フォームの入力値が正常' do
      it 'アカウント登録が成功する' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'saba'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録が完了しました'
        expect(current_path).to eq mypage_path
      end
    end

    context 'フォームの入力値が不正' do
      it 'ニックネームが未入力' do
        visit new_user_path
        fill_in 'ニックネーム', with: nil
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'ニックネームを入力してください'
        expect(current_path).to eq "/users"
      end
      it 'メールアドレスが未入力' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'Saba'
        fill_in 'メールアドレス', with: nil
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(current_path).to eq "/users"
      end
      it 'メールアドレスが既に登録済み' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'Saba'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(current_path).to eq "/users"
      end
      it 'パスワードが未入力' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'Saba'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: nil
        fill_in 'パスワード確認', with: nil
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'パスワードを入力してください'
        expect(current_path).to eq "/users"
      end
      it 'パスワードが3文字未満' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'Saba'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pa'
        fill_in 'パスワード確認', with: 'pa'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'パスワードは3文字以上で入力してください'
        expect(current_path).to eq "/users"
      end
      it 'パスワード確認が未入力' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'Saba'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pa'
        fill_in 'パスワード確認', with: nil
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'パスワード確認を入力してください'
        expect(current_path).to eq "/users"
      end
      it 'パスワードとパスワード確認が一致しない' do
        visit new_user_path
        fill_in 'ニックネーム', with: 'Saba'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'aaa'
        fill_in 'パスワード確認', with: 'iii'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
        expect(current_path).to eq "/users"
      end
    end
  end
end