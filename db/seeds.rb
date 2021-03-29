20.times do |i|
  User.create!(name: "User#{i}",
               email: "user#{i}@test.com",
               password: "password",
               admin: false
               )
end

1.times do |n|
  User.create!(name: "ad",
               email: "ad@dic.com",
               password: "password",
               admin: true
               )
end

User.all.ids.each do |id|
  Task.create!(name: "task#{id}",
               description: "task#{id}_description",
               expired_at: "2021-04-01 00:00:00",
               status: "未着手",
               priority: "中",
               user_id: id
               )
end

Label.create!(
  [
    {
      name: "HTML"
    },
    {
      name: "CSS"
    },
    {
      name: "Rails"
    },
    {
      name: "Javascript"
    },
    {
      name: "Python"
    },
    {
      name: "Java"
    },
    {
      name: "PHP"
    },
    {
      name: "Ruby"
    },
    {
      name: "R"
    },
    {
      name: "PHP"
    },
  ]
)
