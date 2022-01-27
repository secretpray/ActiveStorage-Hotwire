return unless Rails.env == 'development'

puts 'Destroy all records'
puts '*' * 80

User.destroy_all
Post.destroy_all

puts 'Create new records'
puts '*' * 80

MAX_USERS_COUNT = 3
MAX_POSTS_COUNT = 20

#create User
User.create!(email: 'admin@mail.com', password: 'password')
print '.'

(MAX_USERS_COUNT - 1).times do
  User.create!(email: Faker::Internet.email,
               password: 'password')
  print '.'
end

#create Posts
MAX_POSTS_COUNT.times do
  Post.create(title: Faker::Restaurant.name,
              body: Faker::Restaurant.review,
              user: User.all.sample
             )
 print '.'
end

puts ' '
puts ' '
puts "That's all folks!"
puts '*' * 80
p "Created #{Post.count} #{'post'.pluralize(Post.count)}"
p "Created #{User.count} #{'user'.pluralize(User.count)}"
