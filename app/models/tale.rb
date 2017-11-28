class Tale < ApplicationRecord
    belongs_to :genre
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    default_scope { order('rank DESC') }
    
    validates :title, length: { minimum: 1 }, presence: true
    validates :body, length: { minimum: 1 }, presence: true
    validates :genre, presence: true
    validates :user, presence: true

   def up_votes
 # #9
     votes.where(value: 1).count
   end
 
   def down_votes
 # #10
     votes.where(value: -1).count
   end
 
   def points
 # #11
     votes.sum(:value)
   end
   
   def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
     new_rank = points + age_in_days
     update_attribute(:rank, new_rank)
   end
end
