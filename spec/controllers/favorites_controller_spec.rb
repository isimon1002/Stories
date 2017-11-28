require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
   let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:my_genre) { Genre.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:my_tale) { my_genre.tales.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
 
   context 'guest user' do
     describe 'tale create' do
       it 'redirects the user to the sign in view' do
         post :create, params: { tale_id: my_tale.id }
 # #7
         expect(response).to redirect_to(new_user_session_path)
       end
     end
   end
 
   context 'signed in user' do
     before do
       set_session(my_user)
     end
 
     describe 'tale create' do
 # #8
       it 'redirects to the tales show view' do
         post :create, params: { tale_id: my_tale.id }
         expect(response).to redirect_to([my_genre, my_tale])
       end
 
       it 'creates a favorite for the current user and specified tale' do
 # #9
         expect(my_user.favorites.find_by_tale_id(my_tale.id)).to be_nil
 
         post :create, params: { tale_id: my_tale.id }
 
 # #10
         expect(my_user.favorites.find_by_tale_id(my_tale.id)).not_to be_nil
       end
     end
   end

end
