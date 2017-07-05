# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# avatar = Faker::Fillmurray.image

User.create!(name:                   "Bill Murray",
             email:                  "bill@example.com",
             password:               "foobar",
             password_confirmation:  "foobar",
             bio:                    "all around good guy.")
            #  avatar:                  avatar)


49.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.unique.safe_email
  password = "password"
  bio = Faker::StarWars.quote
  avatar = Faker::Avatar.image
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password,
               bio:                   bio,
               avatar:                avatar)
end

20.times do |n|
  name = Faker::Hipster.sentence(1, false)
  info = Faker::Hipster.sentence(2, false, 4)
  Group.create!(name:   name,
                info:   info)
end

# memberships
groups = Group.all
allusers = User.all
users = allusers[1..20]
user2 = allusers[30..50]

groups.each do |group|
  group_id = group.id

  users.each do |user|
    user_id = user.id
    Membership.create!(group_id:  group_id,
                       user_id:   user_id)
  end
end
