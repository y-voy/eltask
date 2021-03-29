FactoryBot.define do

  factory :task do
    name { "test_name" }
    description { "test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "未着手" }
    priority { "中" }
    association :user

    after(:build) do |task|
      label = create(:label)
      task.label_relations << build(:label_relation, task: task, label: label)
    end

  end

  factory :second_task, class: Task do
    name { "second_test_name" }
    description { "second_test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "着手中" }
    priority { "高" }
    association :user

    after(:build) do |task|
      label = create(:second_label)
      task.label_relations << build(:label_relation, task: task, label: label)
    end

  end

  factory :third_task, class: Task do
    name { "third_test_name" }
    description { "third_test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "未着手" }
    priority { "低" }
    association :user

    after(:build) do |task|
      label = create(:third_label)
      task.label_relations << build(:label_relation, task: task, label: label)
    end

  end

  factory :new_task, class: Task do
    name { "new_test_name" }
    description { "new_test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "未着手" }
    priority { "中" }
    association :user
  end

end
