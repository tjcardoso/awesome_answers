# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  q = Question.create title:     Faker::Commerce.product_name,
                      body:       Faker::Lorem.paragraph,
                      email:      Faker::Internet.email,
                      view_count: 0

end

puts Cowsay.say("Generated 100 questions!")
