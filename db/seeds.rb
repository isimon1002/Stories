# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 require 'random_data'
 
  # Create Users
 5.times do
   User.create!(
 # #3
   name:     RandomData.random_name,
   email:    RandomData.random_email,
   password: RandomData.random_sentence
   )
 end
 users = User.all
 
  # Create Genre
1.times  do
Genre.create!(name: 'Comedy', description: 'Funny stories.')
Genre.create!(name: 'Fantasy', description: 'Stories that take place in a different universe with different rules.')
Genre.create!(name: 'Historical Fiction', description: 'Fictitious stories about historical events. ')
Genre.create!(name: 'Horror', description: 'Scary stories')
Genre.create!(name: 'Mystery', description: 'Stories dealing with the unraveling of secrets.')
Genre.create!(name: 'Mythology', description: ' Legend or traditional stories, especially stories containing Gods.')
Genre.create!(name: 'Nonfiction', description: 'True stories')
Genre.create!(name: 'R-rated', description: 'Stories that include mature content.')
Genre.create!(name: 'Realistic Fiction', description: 'Stories that could happen.')
Genre.create!(name: 'Romance', description: 'Stories about romantic relationships.')
Genre.create!(name: 'Satire', description: 'The use of humor, irony, exaggeration, or ridicule to expose and criticize people\'s stupidity or vices.')
Genre.create!(name: 'Science Fiction', description: 'Stories that take place in the future and use futuristic technology.')
Genre.create!(name: 'Tragedy', description: ' Sad stories, or stories with sad endings.')
end
genres = Genre.all

 # Create Stories
 25.times do
   tale = Tale.create!(
     user:   users.sample,
     genre:  genres.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_sentence + RandomData.random_sentence
   )
   
   tale.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
 # #13
   rand(1..5).times { tale.votes.create!(value: [-1, 1].sample, user: users.sample) }
 end
 tales = Tale.all

 # Create Comments
 50.times do
   Comment.create!(
     user: users.sample,
     tale: tales.sample,
     body: RandomData.random_paragraph
   )
  end
  
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Genre.count} genres created"
 puts "#{Tale.count} stories created"
 puts "#{Comment.count} comments created"
 puts "#{Vote.count} votes created"