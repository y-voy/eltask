50.times do |n|
  name = Faker::Name.first_name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end
