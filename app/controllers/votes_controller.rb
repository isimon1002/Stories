class VotesController < ApplicationController
    before_action :user_nil
 
   def up_vote
     update_vote(1)
     redirect_back(fallback_location: :root)
   end
   
   def down_vote
     update_vote(-1)
     redirect_back(fallback_location: :root)
   end
 
   private  
   def update_vote(new_value)
     @tale = Tale.find(params[:tale_id])
     @vote = @tale.votes.where(user_id: current_user.id).first
 
     if @vote
       @vote.update_attribute(:value, new_value)
     else
       @vote = current_user.votes.create(value: new_value, tale: @tale)
     end
   end
   
   def user_nil
       if current_user == nil
       flash[:alert] = "You must be signed in to vote."
       end
   end
end
