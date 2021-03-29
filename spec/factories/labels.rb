FactoryBot.define do

  factory :label do
    name { "new_label" }
  end

  factory :fisrt_label, class: Label do
    name { "first_label" }
  end

  factory :second_label, class: Label do
    name { "second_label" }
  end

  factory :third_label, class: Label do
    name { "third_label" }
  end

end
