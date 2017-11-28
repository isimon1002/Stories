class FavoritesController < ApplicationController
   before_action :user_nil
   
   def create
 # #12
     tale = Tale.find(params[:tale_id])
     favorite = current_user.favorites.build(tale: tale)
 
     if favorite.save
       flash[:notice] = "Story favorited."
     else
       flash[:alert] = "Favoriting failed."
     end
 
 # #13
     redirect_to [tale.genre, tale]
   end
   
   def destroy
     tale = Tale.find(params[:tale_id])
     favorite = current_user.favorites.find(params[:id])
 
     if favorite.destroy
       flash[:notice] = "Story unfavorited."
     else
       flash[:alert] = "Unfavoriting failed."
     end
       redirect_to [tale.genre, tale]
   end
   
   private
   
   def user_nil
       if current_user == nil
          flash[:alert] = "You must be signed in to favorite stories."
          redirect_to new_user_session_path
       end
   end
end
