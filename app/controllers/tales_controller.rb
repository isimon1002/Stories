class TalesController < ApplicationController
  def index
    @tales = Tale.all
  end

  def show
    @tale = Tale.find(params[:id])
  end

  def new
    @tale = Tale.new
  end

  def create
    @tale = Tale.new
    @tale.title = params[:tale][:title]
    @tale.body = params[:tale][:body]
    if @tale.save
       flash[:notice] = "Your story was saved.  Thank you for sharing it with the world."
       redirect_to @tale
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
 
     if @tale.save
       flash[:notice] = "Your story was updated.  Thank you for updating it."
       redirect_to @tale
     else
       flash.now[:alert] = "There was an error updating your story.  Please try again later.  If the problem persists, please notify tech support at ijsimon@sbcglobal.net."
       render :edit
     end
  end
  
  def destroy
     @tale = Tale.find(params[:id])
      if @tale.destroy
       flash[:notice] = "\"#{@tale.title}\" was deleted successfully."
       redirect_to tales_path
     else
       flash.now[:alert] = "There was an error deleting your story."
       render :show
      end
  end
end