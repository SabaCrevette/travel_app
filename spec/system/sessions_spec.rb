require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

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

      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'Email', with: 'aaa@aaa'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq mypage_path
      end
    end
  end
end
