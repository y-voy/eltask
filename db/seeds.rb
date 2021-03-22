50.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
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
    }
  ]
)
