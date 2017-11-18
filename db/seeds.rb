# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 require 'random_data'

 # Create Posts
 5.times do
 # #1
   Tale.create!(
 # #2
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 tales = Tale.all
 
 # Create Comments
 # #3
 10.times do
   Comment.create!(
 # #4
     tale: tales.sample,
     body: RandomData.random_paragraph
   )
 end
 
 puts "Seed finished"
 puts "#{Tale.count} posts created"
 puts "#{Comment.count} comments created"