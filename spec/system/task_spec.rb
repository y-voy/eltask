require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  let!(:task) { FactoryBot.create(:task, created_at: Time.current + 1.days, expired_at: Time.current + 3.days) }
  let!(:second_task) { FactoryBot.create(:second_task, created_at: Time.current + 2.days, expired_at: Time.current + 2.days) }
  let!(:third_task) { FactoryBot.create(:third_task, created_at: Time.current, expired_at: Time.current + 1.days) }

  describe '新規作成機能' do
    before do
      visit new_task_path
      task = FactoryBot.create(:new_task)
      fill_in 'タスク名', with: task.name
      fill_in '詳細', with: task.description
      fill_in '終了期限', with: task.expired_at
      click_button '登録する'
    end

    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        expect(page).to have_content 'new_test_name'
        expect(page).to have_content 'new_test_description'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test_name'
        expect(page).to have_content 'second_test_name'
        expect(page).to have_content 'third_test_name'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        all('tr td')[3].click_link '詳細'
        expect(page).to have_content 'second_test_name'
      end
    end

    context '終了期限でソートするボタンが押された場合' do
      before do
        within '#sort_expired' do
          click_link '終了期限でソートする'
        end
      end
      it '終了期限が一番手前の日付が一番上に表示される' do
        all('tr td')[3].click_link '詳細'
        expect(page).to have_content 'third_test_name'
      end
    end

  end

  describe '詳細表示機能' do
    before do
      visit task_path(task)
    end
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         expect(page).to have_content 'test_name'
       end
     end
  end

end
