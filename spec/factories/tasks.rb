FactoryBot.define do

  factory :task do
    name { "test_name" }
    description { "test_description" }
  end

  factory :new_task, class: Task do
    name { "new_test_name" }
    description { "new_test_description" }
  end

  factory :second_task, class: Task do
    name { "second_test_name" }
    description { "second_test_description" }
  end

  factory :third_task, class: Task do
    name { "third_test_name" }
    description { "third_test_description" }
  end

end
