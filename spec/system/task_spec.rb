require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  let(:task_a) { FactoryBot.create(:task, name: 'name_a', description: 'description_a') }

  describe '新規作成機能' do
    before do
      visit new_task_path
      task = FactoryBot.create(:task)
      fill_in 'タスク名', with: task.name
      fill_in '詳細', with: task.description
      click_button '登録する'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        expect(page).to have_content 'test_name'
        expect(page).to have_content 'test_description'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      visit task_path(task_a)
    end
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         expect(page).to have_content 'name_a'
       end
     end
  end

end
