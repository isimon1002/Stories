class TalesController < ApplicationController
  
  before_action :user_nil, except: :show
  before_action :authorize_edit, except: [:show, :new, :create]
  before_action :authorize_new, except: [:show, :edit]
  
  def show
    @tale = Tale.find(params[:id])
  end

  def new
    @genre = Genre.find(params[:genre_id])
    @tale = Tale.new
  end

  def create
    @tale = Tale.new
    @tale.title = params[:tale][:title]
    @tale.body = params[:tale][:body]
    @tale.isPublic = params[:tale][:isPublic]
    @tale.count = WordsCounted.count(@tale.body).token_count
    @tale.user = current_user
    @genre = Genre.find(params[:genre_id])
 # #35
     @tale.genre = @genre
     if WordsCounted.count(@tale.body).token_count > 3
         @tale.isPublic = true
     end
    if @tale.save
       flash[:notice] = "Your story was saved.  Thank you for sharing it with the world."
       
       redirect_to [@genre, @tale]
    else
       flash.now[:alert] = "There was an error saving your story.  Please try again later.  If the problem persists, please notify tech support at ijsimon@sbcglobal.net."
       render :new
    end
  end
  
  def edit
    @tale = Tale.find(params[:id])
  end
  
  def update
     @tale = Tale.find(params[:id])
     @tale.title = params[:tale][:title]
     @tale.body = params[:tale][:body]
     @tale.isPublic = params[:tale][:isPublic]
     @tale.count = WordsCounted.count(@tale.body).token_count
     
     if WordsCounted.count(@tale.body).token_count > 999
         @tale.isPublic = true
     end
     if WordsCounted.count(@tale.body).token_count < 999
         @tale.isPublic = false
     end
     if @tale.save
       flash[:notice] = "Your story was updated.  Thank you for updating it."
       redirect_to [@tale.genre, @tale]
     else
       flash.now[:alert] = "There was an error updating your story.  Please try again later.  If the problem persists, please notify tech support at ijsimon@sbcglobal.net."
       render :edit
     end
  end
  
  def destroy
     @tale = Tale.find(params[:id])
      if @tale.destroy
       flash[:notice] = "\"#{@tale.title}\" was deleted successfully."
       redirect_to @tale.genre
     else
       flash.now[:alert] = "There was an error deleting your story."
       render :show
      end
  end
  
  private
   def authorize_edit
       tale = Tale.find(params[:id])
 # #11
     unless current_user == tale.user
       flash[:alert] = "You must be the author of a story to edit it."
       redirect_to [tale.genre, tale]
     end
   end
   
   def authorize_new
     @genre = Genre.find(params[:genre_id])
     @tale = Tale.new
     
     unless current_user.author? || current_user.admin?
       flash[:alert] = "You must be an author to write new stories.  Please see the about section for how to become an author."
       redirect_to genres_path
     end
   end
   
   def user_nil
       if current_user == nil
       flash[:alert] = "You must be signed in to create content."
       redirect_to genres_path
       end
   end
end