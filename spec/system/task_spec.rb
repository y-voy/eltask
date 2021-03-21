require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  let!(:user_a) { FactoryBot.create(:user, name: "ユーザーA", email: "a@dic.com") }
  let!(:task) { FactoryBot.create(:task, created_at: Time.current + 1.days, expired_at: Time.current + 3.days, priority: 1, user: user_a) }
  let!(:second_task) { FactoryBot.create(:second_task, created_at: Time.current + 2.days, expired_at: Time.current + 2.days, priority: 3, user: user_a) }
  let!(:third_task) { FactoryBot.create(:third_task, created_at: Time.current, expired_at: Time.current + 1.days, priority: 2, user: user_a) }

  before do
    visit new_session_path
    fill_in 'Email', with: 'a@dic.com'
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
  end

  describe '新規作成機能' do
    before do
      visit new_task_path
      task = FactoryBot.create(:new_task, user: user_a)
      fill_in 'タスク名', with: task.name
      fill_in '詳細', with: task.description
      fill_in '終了期限', with: task.expired_at
      select '未着手', from: "task_status_field"
      select '中', from: "task_priority_field"
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
        all('tr td')[6].click_link '詳細'
        expect(page).to have_content 'second_test_name'
      end
    end

    context '終了期限でソートするボタンが押された場合' do
      before do
        within '#sort_expired' do
          click_link '終了期限'
        end
      end
      it '終了期限が一番手前の日付が一番上に表示される' do
        all('tr td')[6].click_link '詳細'
        expect(page).to have_content 'third_test_name'
      end
    end

    context '優先順位でソートするボタンが押された場合' do
      before do
        within '#sort_priority' do
          click_link '優先順位'
        end
      end
      it '優先順位が高いタスクが一番上に表示される' do
        all('tr td')[6].click_link '詳細'
        sleep 2
        expect(page).to have_content 'second_test_name'
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

  describe '検索機能' do
    before do
     FactoryBot.create(:second_task, name: "foo", user: user_a)
     FactoryBot.create(:task, name: "sample", status: "完了", user: user_a)
   end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "name_search_feild", with: "foo"
        click_button "検索"
        expect(page).to have_content 'foo'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select(value = "完了", from: "status_search_feild")
        click_button "検索"
        expect(page).to have_content 'sample'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "name_search_feild", with: "foo"
        select(value = "着手中", from: "status_search_feild")
        click_button "検索"
        expect(page).to have_content 'foo'
      end
    end
  end

end
