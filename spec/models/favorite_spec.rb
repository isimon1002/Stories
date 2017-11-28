require 'rails_helper'

RSpec.describe Favorite, type: :model do
   let(:genre) { Genre.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:tale) { genre.tales.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:favorite) { Favorite.create!(tale: tale, user: user) }
 
   it { is_expected.to belong_to(:tale) }
   it { is_expected.to belong_to(:user) }
end
