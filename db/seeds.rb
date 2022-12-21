# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "\n== Seeding the database with fixtures =="
system("bin/rails db:fixtures:load")

User.all.each do |user|
  user.avatar.attach(io: File.open('app/assets/images/default_avatar.jpg'), filename: 'default_avatar.jpg', content_type: 'image/png')
  user.update(confirmed_at: DateTime.now)
end