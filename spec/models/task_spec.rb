require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', description: '失敗テスト', expired_at: '2021-04-01 00:00:00', status: '未着手')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: 'test_task', description: '', expired_at: '2021-04-01 00:00:00', status: '未着手')
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'test_task', description: 'test_description', expired_at: '2021-04-01 00:00:00', status: '未着手')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, name: 'foo', status: "着手中") }
    let!(:second_task) { FactoryBot.create(:second_task, name: "sample", status: "未着手") }
    let!(:third_task) { FactoryBot.create(:third_task, name: "bar", status: "完了") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.name_search('foo')).to include(task)
        expect(Task.name_search('foo')).not_to include(second_task)
        expect(Task.name_search('foo').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search(2)).to include(task)
        expect(Task.status_search(2)).not_to include(second_task)
        expect(Task.status_search(2).count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_search('bar') && Task.status_search(3)).to include(third_task)
        expect(Task.name_search('bar') && Task.status_search(3)).not_to include(second_task)
        expect((Task.name_search('bar') && Task.status_search(3)).count).to eq 1
      end
    end
  end

end
