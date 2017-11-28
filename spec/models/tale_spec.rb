require 'rails_helper'

RSpec.describe Tale, type: :model do
   let(:name) { RandomData.random_sentence }
   let(:description) { RandomData.random_paragraph }
   let(:title) { RandomData.random_sentence }
   let(:body) { RandomData.random_paragraph }
 # #3
   let(:genre) { Genre.create!(name: name, description: description) }
 # #4
   let(:tale) { genre.tales.create!(title: title, body: body, user: user) }
   let(:user) { User.create!(name: 'name', email: 'email@email', password: 'password') }
 
   it { is_expected.to belong_to(:genre) }
   it { is_expected.to have_many(:favorites) }
   it { is_expected.to have_many(:votes) }
 
 # #2
   describe "attributes" do
     it "has title and body attributes" do
       expect(tale).to have_attributes(title: title, body: body)
     end
   end
   
   describe "voting" do
 # #5
     before do
       3.times { tale.votes.create!(value: 1, user: user) }
       2.times { tale.votes.create!(value: -1, user: user) }
       @up_votes = tale.votes.where(value: 1).count
       @down_votes = tale.votes.where(value: -1).count
     end
 
 # #6
     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( tale.up_votes ).to eq(@up_votes)
       end
     end
 
 # #7
     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( tale.down_votes ).to eq(@down_votes)
       end
     end
 
 # #8
     describe "#points" do
       it "returns the sum of all down and up votes" do
         expect( tale.points ).to eq(@up_votes - @down_votes)
       end
     end
   end
end
