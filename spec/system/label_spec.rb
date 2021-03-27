require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :system do

  let!(:admin) { FactoryBot.create(:admin) }
  let!(:task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:second_task, user: task.user) }
  let!(:third_task) { FactoryBot.create(:third_task, user: task.user) }

  describe 'ラベル機能' do

    before do
      visit new_session_path
      fill_in 'Email', with: 'test@dic.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end

    context 'タスクにラベルを紐付けた場合' do
      it 'タスク詳細でラベルが確認できる' do
        visit task_path(task)
        expect(page).to have_content 'new_label'
      end

    end

    context 'ラベル検索をした場合' do
      it "ラベルに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select(value = "second_label", from: "task_label_id")
        click_button "検索"
        expect(page).to have_content 'second_test_name'
      end
    end
  end

  describe 'ラベル管理機能' do

    before do
      visit new_session_path
      fill_in 'Email', with: 'admin@dic.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
      visit new_admin_label_path
    end

    context '管理ユーザーがログインした場合' do

      before do
        fill_in 'ラベル名', with: 'new_label'
        click_button '登録する'
      end
      it 'ラベルの新規登録ができる' do
        visit admin_labels_path
        expect(page).to have_content 'new_label'
      end

    end

  end

end
