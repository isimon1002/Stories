require 'rails_helper'

RSpec.describe Genre, type: :model do
   let(:name) { RandomData.random_sentence }
   let(:description) { RandomData.random_paragraph }
   let(:public) { true }
   let(:genre) { Genre.create!(name: name, description: description) }
   
   it { is_expected.to have_many(:tales) }

 # #1
   describe "attributes" do
     it "has name, description, and public attributes" do
       expect(genre).to have_attributes(name: name, description: description, public: public)
     end

 # #2
     it "is public by default" do
       expect(genre.public).to be(true)
     end
   end
end
