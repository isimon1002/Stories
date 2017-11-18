require 'rails_helper'

RSpec.describe Tale, type: :model do
     let(:tale) { Tale.create!(title: "New Post Title", body: "New Post Body") }
 
 # #2
   describe "attributes" do
     it "has title and body attributes" do
       expect(tale).to have_attributes(title: "New Post Title", body: "New Post Body")
     end
   end
end
