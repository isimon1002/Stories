class CommentsController < ApplicationController
   before_action :user_nil
   before_action :authorize_user, only: [:destroy]
   
   def create
 # #11
     @tale = Tale.find(params[:tale_id])
     comment = @tale.comments.new(comment_params)
     comment.user = current_user
 
     if comment.save
       flash[:notice] = "Comment saved successfully."
 # #12
       redirect_to [@tale.genre, @tale]
     else
       flash[:alert] = "Comment failed to save.  Please contact ijsimon@sbcglobal.net if this problem persits."
 # #13
       redirect_to [@tale.genre, @tale]
     end
   end
   
   def destroy
     @tale = Tale.find(params[:tale_id])
     comment = @tale.comments.find(params[:id])
 
     if comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to [@tale.genre, @tale]
     else
       flash[:alert] = "Comment couldn't be deleted. If this problem persists contact ijsimon@sbcglobal.net"
       redirect_to [@tale.genre, @tale]
     end
   end
 
   private
 
 # #14
   def comment_params
     params.require(:comment).permit(:body)
   end
   
   def user_nil
       if current_user == nil
       flash[:alert] = "You must be signed in to create content."
       redirect_to genres_path
       end
   end
   
   def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You must be the author of a comment to delete it."
       redirect_to [comment.tale.genre, comment.tale]
     end
   end
end

