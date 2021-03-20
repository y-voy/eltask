FactoryBot.define do

  factory :user do
    name { "tester" }
    email { "test@dic.com" }
    password { "password" }
    admin { false }
  end

  factory :admin, class: User do
    name { "admin" }
    email { "admin@dic.com" }
    password { "password" }
    admin { true }
  end

end
