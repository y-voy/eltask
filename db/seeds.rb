50.times do |n|
  name = Faker::Name.first_name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               admin: false
               )
end

1.times do |n|
  User.create!(name: admin,
               email: admin@dic.com,
               password: "password",
               admin: true
               )
end
