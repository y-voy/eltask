require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:admin) { FactoryBot.create(:admin) }

  describe 'ユーザー登録機能' do

    context 'ユーザーを新規登録した場合' do

      before do
        visit new_user_path
        fill_in '名前', with: 'ユーザーA'
        fill_in 'メールアドレス', with: 'user_a@dic.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button 'ユーザー新規登録'
      end

      it '登録ユーザーの詳細画面が表示される' do
        expect(page).to have_content 'ユーザーAのページ'
        expect(page).to have_content 'user_a@dic.com'
      end
    end

    context 'ログイン前にタスク一覧に遷移しようとした場合' do

      before do
        visit tasks_path
      end

      it 'ログイン画面に遷移する' do
        expect(page).to have_content 'ログイン'
      end
    end

  end

  describe 'セッション機能' do

    before do
      visit new_session_path
      fill_in 'Email', with: 'test@dic.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end

    context 'ユーザーがログインをした場合' do

      before do
        visit tasks_path
      end

      it 'タスク一覧に遷移できる' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'ログアウト'
      end
    end

    context 'ユーザーがログインをした場合' do

      before do
        visit tasks_path
        click_link 'プロフィール'
      end

      it '自身の詳細ページにとぶことができる' do
        expect(page).to have_content 'testerのページ'
        expect(page).to have_content 'test@dic.com'
      end
    end

    context 'ユーザーがログインをした場合' do

      before do
        other_user = FactoryBot.create(:user, email: 'other_user@dic.com')
        visit user_path(other_user.id)
      end

      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'ログアウト'
      end
    end

    context 'ユーザーがログインをした場合' do

      before do
        visit tasks_path
        click_link 'ログアウト'
      end

      it 'ログアウトができる' do
        expect(page).to have_content 'ログイン'
      end
    end

  end

  describe '管理画面機能' do

    context '一般ユーザーがログインした場合' do

      before do
        visit new_session_path
        fill_in 'Email', with: 'test@dic.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
      end

      it '管理画面にアクセスできない' do
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end

    end

    context '管理ユーザーがログインした場合' do

      before do
        visit new_session_path
        fill_in 'Email', with: 'admin@dic.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        visit admin_users_path
      end

      it '管理画面にアクセスできる' do
        expect(page).to have_content 'ユーザー一覧'
        expect(page).to have_content 'tester'
      end

      it 'ユーザーの新規登録ができる' do
        click_link '新規登録'
        fill_in '名前', with: 'ユーザーA'
        fill_in 'メールアドレス', with: 'user_a@dic.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'ユーザーA'
      end

      it 'ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(user)
        expect(page).to have_content 'tester'
      end

      it 'ユーザーの編集画面から編集ができる' do
        visit edit_admin_user_path(user)
        fill_in '名前', with: 'edit_user'
        fill_in 'メールアドレス', with: 'edit_user@dic.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button '更新する'
        expect(page).to have_content 'edit_user'
      end

      it 'ユーザーを削除できる' do
      all('tr td')[6].click_link '削除'
      page.accept_confirm do
      end
      expect(page).not_to have_content 'test@dic.con'
      end

    end


  end

end
