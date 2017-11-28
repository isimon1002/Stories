class Comment < ApplicationRecord
  belongs_to :tale
  belongs_to :user
  
  after_create :send_favorite_emails
 
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
   
      
 
   private
 
   def send_favorite_emails
     tale.favorites.each do |favorite|
       FavoriteMailer.new_comment(favorite.user, tale, self).deliver_now
     end
   end
end
