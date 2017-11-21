require 'rails_helper'

RSpec.describe Comment, type: :model do
   let(:genre) { Genre.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:tale) { genre.tales.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
   let(:comment) { Comment.create!(body: 'Comment Body', tale: tale) }
 
   describe "attributes" do
     it "has a body attribute" do
       expect(comment).to have_attributes(body: "Comment Body")
     end
   end
end
