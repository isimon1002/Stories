require 'rails_helper'

RSpec.describe Vote, type: :model do
   let(:genre) { Genre.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:tale) { genre.tales.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:vote) { Vote.create!(value: 1, tale: tale, user: user) }
 
 # #1
   it { is_expected.to belong_to(:tale) }
   it { is_expected.to belong_to(:user) }
 # #2
   it { is_expected.to validate_presence_of(:value) }
 # #3
   it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }
   
   describe "update_tale callback" do
     it "triggers update_tale on save" do
 # #26
       expect(vote).to receive(:update_tale).at_least(:once)
       vote.save!
     end
 
     it "#update_tale should call update_rank on tale " do
 # #27
       expect(tale).to receive(:update_rank).at_least(:once)
       vote.save!
     end
   end
   
   describe "#update_rank" do
 # #28
       it "calculates the correct rank" do
         tale.update_rank
         expect(tale.rank).to eq (tale.points + (tale.created_at - Time.new(1970,1,1)) / 1.day.seconds)
       end
 
       it "updates the rank when an up vote is created" do
         old_rank = tale.rank
         tale.votes.create!(value: 1, user: user)
         expect(tale.rank).to eq (old_rank + 1)
       end
 
       it "updates the rank when a down vote is created" do
         old_rank = tale.rank
         tale.votes.create!(value: -1, user: user)
         expect(tale.rank).to eq (old_rank - 1)
       end
     end
end
