 require 'faker'

 # Create Users
 5.times do
   user = User.new(
     name:     Faker::Name.name,
     email:    Faker::Internet.email,
     password: Faker::Lorem.characters(10),
     created_at: Faker::Date.between(7.days.ago, 5.days.ago)
   )
   user.skip_confirmation!
   user.save!
 end
  user = User.new(
     name:     'junko',
     email:    'aliciajace@gmail.com',
     password: 'helloworld',
     created_at: Faker::Date.between(7.days.ago, 5.days.ago)
   )
   user.skip_confirmation!
   user.save!
 users = User.all
 
 # Note: by calling `User.new` instead of `create`,
 # we create an instance of User which isn't immediately saved to the database.
 
 # The `skip_confirmation!` method sets the `confirmed_at` attribute
 # to avoid triggering an confirmation email when the User is saved.
 
 # The `save` method then saves this User to the database.
 # Create Topics
 15.times do
   Topic.create!(
     name:         Faker::Lorem.sentence,
     description:  Faker::Lorem.paragraph
   )
 end
 topics = Topic.all


 # Create Posts
 50.times do
   post= Post.create!(
     user:   users.sample,
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph,
     topic:  topics.sample,
     created_at: Faker::Date.between(5.days.ago, Date.today)
   )
      # set the created_at to a time within the past year
   post.update_rank
   post.create_vote
 end
 posts = Post.all

 # Create Comments
 100.times do
   Comment.create!(
     user: users.sample,   
     post: posts.sample,
     body: Faker::Lorem.paragraph
   )
 end

 # Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!
 
 # Create a moderator
 moderator = User.new(
   name:     'Moderator User',
   email:    'moderator@example.com',
   password: 'helloworld',
   role:     'moderator'
 )
 moderator.skip_confirmation!
 moderator.save!
 
 # Create a member
 member = User.new(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )
 member.skip_confirmation!
 member.save!



 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"