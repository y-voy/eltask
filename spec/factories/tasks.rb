FactoryBot.define do

  factory :task do
    name { "test_name" }
    description { "test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "未着手" }
    priority { "中" }
    user
  end

  factory :second_task, class: Task do
    name { "second_test_name" }
    description { "second_test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "着手中" }
    priority { "高" }
    user
  end

  factory :third_task, class: Task do
    name { "third_test_name" }
    description { "third_test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "未着手" }
    priority { "低" }
    user
  end

  factory :new_task, class: Task do
    name { "new_test_name" }
    description { "new_test_description" }
    expired_at { "2021-04-01 00:00:00" }
    status { "未着手" }
    priority { "中" }
    user
  end

end
