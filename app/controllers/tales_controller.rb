class TalesController < ApplicationController

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
    @genre = Genre.find(params[:genre_id])
 # #35
     @tale.genre = @genre
     if WordsCounted.count(@tale.body).token_count > 999
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
end